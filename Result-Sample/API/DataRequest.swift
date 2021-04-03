
import Foundation
import Alamofire

final class DataRequest {
    static let shared = DataRequest()
    private init() {}
    
    // Result型
    // 成功時も失敗時も必ず、レスポンスがあるのでnilを気にしなくても良い
    func githubApi(complition: ((Result<[GithubModel], Error>) -> Void)? = nil) {
        let apiUrlStr = "https://api.github.com/search/repositories?q=Swift&sort=stars"
        
        AF.request(apiUrlStr, method: .get).responseJSON { (responce) in
            if let error = responce.error {
                complition?(.failure(error))
                return
            }
            guard
                let data = responce.data,
                let decodeData = try? JSONDecoder().decode(APIResponce.self, from: data) else {
                complition?(.failure(AppError.decodeApi.error))
                return
            }
            let githubModel = decodeData.items
            complition?(.success(githubModel))
        }
    }
}
