import UIKit

//MARK: - 에러
enum DNetworkError: Error {
    case dNetworkError
    case dDataError
    case dParseError
}

//MARK: - 네트워크 fetch
class DetectorNetworkManager {
    
    static let detectedShared = DetectorNetworkManager()
    private init(){}
    
    typealias detectedNetworkCompletion = (Result<WelcomeDetected, DNetworkError>) -> Void
    
    func fetchText(detectTerm: String, completion: @escaping detectedNetworkCompletion){
        let param = "query=\(detectTerm)"
        guard let paramData = param.data(using: .utf8) else {return}
        
        postDetectMethod(with: paramData) { result in
            completion(result)
        }
    }
    
//MARK: - 네트워크 POST
    func postDetectMethod(with paramData: Data, completion: @escaping detectedNetworkCompletion){
        
        guard let url = URL(string: DetectAPI.detectBasicURL) else {
            print("ERROR: Cannot Create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(DetectAPI.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(DetectAPI.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = paramData
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.dNetworkError))
            }
            
            guard let safeData = data else {
                print("ERROR: Data Error")
                completion(.failure(.dDataError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("ERROR: Request Error")
                return
            }
            
            if let detect = self.detectParseJSON(safeData) {
                print("Success Parse")
                completion(.success(detect))
            } else {
                print("Failed Parse")
                completion(.failure(.dParseError))
            }
            
        }
        task.resume()
    }
    
//MARK: - JSON Parse
    func detectParseJSON(_ paramData: Data) -> WelcomeDetected? {
        do {
            let detectData = try JSONDecoder().decode(WelcomeDetected.self, from: paramData)
            print(detectData)
            return detectData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
