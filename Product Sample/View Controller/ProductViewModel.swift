//
//  ProductViewModel.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import Foundation
import UIKit

//MARK: - Send Api data in delegate
protocol productListModelDelegate {
    func didReceiveProductResponse(response: UserList)
}
//MARK: - Api calling
struct ProdcutViewModel{
    
    var delegate: productListModelDelegate?
    
    func getProductListAPI(param : [String:Any]){
        Config.showHud()
        
        WebServiceHelper.webServiceCall(methodname: Config().API_URL, parameter: [:] as NSDictionary, httpType: "GET", controller: ProductsVC()) { (status, data, responseData, error)  in
            if status{
                do{
                    let decodedResponse = try JSONDecoder().decode(UserList.self, from: data!)
                    print(decodedResponse)
                    self.delegate?.didReceiveProductResponse(response: decodedResponse)
                }catch let error{
                    debugPrint("deocding error =>\(error)")
                }
            }else{
                if error != nil{
                    print(error as Any)
                    //Config().showError(title: error as! String)
                }
            }
            Config.dissmissHud()
        }
    }
}
