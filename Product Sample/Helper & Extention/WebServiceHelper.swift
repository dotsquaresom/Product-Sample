import UIKit
import SystemConfiguration

class WebServiceHelper: NSObject{
    
    class func isConnectedToNetwork()->Bool{
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
        
    }
    static func webServiceCall(methodname : String, parameter : NSDictionary, httpType: String, controller : UIViewController? , completeBlock:@escaping (_ status : Bool,_ data : Data?, _ responseData : NSDictionary?, _ error : NSError?)->()){
        if self.isConnectedToNetwork() == true{
            let baseUrl = methodname//Config().API_URL + methodname
            let url = NSURL(string: baseUrl)
            print(url as Any)
            print(parameter)
            
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = httpType
            
            request.timeoutInterval = 90;
            print(request.allHTTPHeaderFields as Any)
            let err : NSError?
            err = nil
            
            if httpType == "POST"{
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: []);
                } catch _ {
                }
            }
            do {
                if let postData : NSData = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData?{
                    
                    let json = NSString(data: postData as Data, encoding: String.Encoding.utf8.rawValue)! as String
                    print(json)
                }
            }
            catch {
                //print(error)
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                let error: AutoreleasingUnsafeMutablePointer<NSError?>? = nil
                if data != nil{
                    var jsonResult: NSDictionary!
                    jsonResult = nil
                    do {
                        NSLog(String(data: data!, encoding: String.Encoding.utf8)!)
                        jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print(jsonResult as Any)
                    } catch _ {
                    }
                    
                    if jsonResult == nil{
                        DispatchQueue.main.async{
                            completeBlock(false, data,jsonResult, err)
                        }
                    }else{
                        DispatchQueue.main.async{
                            completeBlock(true,data, jsonResult, nil)
                        }
                    }
                }else if error != nil{
                    DispatchQueue.main.async{
                        completeBlock(false,nil, nil, err)
                        //Config().showError(title: err as? String ?? "Something went wrong.please try again.")
                        Config.dissmissHud()
                    }
                }else{
                    DispatchQueue.main.async{
                        completeBlock(false,nil, nil, err)
                        //Config().showError(title: "Either internet connection is slow or server is not responding at the moment. Please try again later.")
                        Config.dissmissHud()
                    }
                }
            }
            task.resume()
        }else{
            
        }
    }
    static func generateBoundaryString() -> String {
        return "************"
    }
}


