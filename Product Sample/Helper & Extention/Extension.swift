import UIKit
import AVFoundation
import AVKit

class DataManager {
    class func getVal(_ param:Any!) -> AnyObject {
        
        if param == nil{
            return "" as AnyObject
        }else if param is NSNull{
            return "" as AnyObject
        }else if param is NSNumber{
            let aString:String = "\(param!)"
            return aString as AnyObject
        }else if param is Double{
            return "\(String(describing: param))" as AnyObject
        }else{
            return param as AnyObject
        }
    }
}
extension UIViewController{
    func presentViewController(_ PresentController: UIViewController){
        let DetailVC = PresentController
        let navctrl = UINavigationController(rootViewController: DetailVC)
        self.present(navctrl, animated: true, completion: nil)
    }
    func RootViewControllerWithNav(_ RootViewController: UIViewController){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.duration = 0.2
        slideInFromLeftTransition.type = .fade
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom;
        self.view.window?.layer.add(slideInFromLeftTransition, forKey: kCATransition)
        let navctrl = UINavigationController(rootViewController: RootViewController)
        self.view.window?.rootViewController = navctrl
    }
    
    func onlyPushViewController(_ PushController: UIViewController){
        let DetailVC = PushController
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
}
