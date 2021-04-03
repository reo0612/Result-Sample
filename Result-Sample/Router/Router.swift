
import UIKit

final class Router {
    static func showRoot(window: UIWindow) {
        let firstVC = UIStoryboard(name: StoryboardName.first.rawValue, bundle: nil).instantiateInitialViewController() as! FirstViewController
        window.rootViewController = firstVC
        window.makeKeyAndVisible()
    }
}
