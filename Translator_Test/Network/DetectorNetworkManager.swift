import UIKit

enum DNetworkError: Error {
    case dNetworkError
    case dDataError
    case dParseError
}

class DetectorNetworkManager {
    
    static let detectedShared = DetectorNetworkManager()
    private init(){}
    
    //typealias detectedNetworkCompletion = (Result<WelcomeDetected, DNetworkError>) -> Void
    
}
