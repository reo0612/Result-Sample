
import Foundation

enum AppError: Int {
    case decodeApi
    
    var domain: String {
        switch self {
        case .decodeApi:
            return "デコードに失敗しました"
        }
    }

    var error: NSError {
        NSError(domain: domain, code: rawValue, userInfo: nil)
    }
}
