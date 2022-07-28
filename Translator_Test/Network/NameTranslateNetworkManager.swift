import UIKit

enum NNetworkError: Error {
    case nNetworkError
    case nDataError
    case nParseError
}

class NameTranslateNetworkManager {
    
    static let nameShared = NameTranslateNetworkManager()
    private init(){}
    
    //typealias nameNetworkCompletion = (Result<[AResult],NNetworkError>) -> Void
}
