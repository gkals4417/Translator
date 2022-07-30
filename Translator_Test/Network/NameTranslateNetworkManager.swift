import UIKit

enum NNetworkError: Error {
    case nNetworkError
    case nDataError
    case nParseError
}

//MARK: - 네트워크 fetch
class NameTranslateNetworkManager {
    
    static let nameShared = NameTranslateNetworkManager()
    private init(){}
    
    typealias nameNetworkCompletion = (Result<[AResult],NNetworkError>) -> Void
    
    func fetchNameTrans(yourName: String, completion: @escaping nameNetworkCompletion){
        let unencodedUrlString = "\(NameTransAPI.nameTransBasicURL)?query=\(yourName)"
        guard let urlString = unencodedUrlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {return}
        
        getNameTransMethod(with: urlString) { result in
            completion(result)
        }
    }

//MARK: - 네트워크 GET
    private func getNameTransMethod(with urlString: String, completion: @escaping nameNetworkCompletion){
        guard let url = URL(string: urlString) else {
            print("ERROR: Cannot Create URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(NameTransAPI.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(NameTransAPI.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.nNetworkError))
                return
            }
            
            guard let safeData = data else {
                print("ERROR: Data Error")
                completion(.failure(.nDataError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("ERROR: Request Error")
                return
            }
            
            if let name = self.getParseJSON(safeData){
                print("Success Parse")
                completion(.success(name))
            } else {
                print("Failed Parse")
                completion(.failure(.nParseError))
            }

        }
        task.resume()
    }
  
//MARK: - JSON Parse
    private func getParseJSON(_ data: Data) -> [AResult]? {
        do {
            let transNameData = try JSONDecoder().decode(WelcomeNameTranslate.self, from: data)
            //print(transNameData)
            return transNameData.aResult
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
