import UIKit

//MARK: - 에러
enum TNetworkError: Error {
    case tNetworkError
    case tDataError
    case tParseError
}
//MARK: - 네트워크 fetch
class TransLateNetworkManager {
    
    static let transShared = TransLateNetworkManager()
    private init(){}
    
    typealias transNetworkCompletion = (Result<TransResult,TNetworkError>) -> Void
    
    func fetchTrans(srcString: String, targetString: String, text: String, completion: @escaping transNetworkCompletion){
        let param = "source=\(srcString)&target=\(targetString)&text=\(text)"
        guard let paramData = param.data(using: .utf8) else {return}
        
        postText(with: paramData) { result in
            completion(result)
        }
    }
    
//MARK: - 네트워크 POST
    private func postText(with paramData: Data, completion: @escaping transNetworkCompletion){
        
        guard let url = URL(string: TransAPI.transBasicURL) else {
            print("ERROR: Cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(TransAPI.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(TransAPI.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = paramData
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.tNetworkError))
                return
            }
            
            guard let safeData = data else {
                print("ERROR: Data Error")
                completion(.failure(.tDataError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("ERROR: Request Error")
                return
            }
            
            if let trans = self.postParseJSON(safeData){
                print("Success parse")
                completion(.success(trans.result))
                
            } else {
                print("Faild parse")
                completion(.failure(.tParseError))
            }
        }
        task.resume()
        
    }
    
//MARK: - JSON Parse
    private func postParseJSON(_ paramData: Data) -> Message? {
        do {
            let transData = try JSONDecoder().decode(WelcomeTranslate.self, from: paramData)
            print(transData)
            return transData.message
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
