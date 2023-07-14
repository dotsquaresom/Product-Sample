//
//  SuccessVC.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 14/07/23.
//

import UIKit

class SuccessVC: UIViewController {

    //MARK: - Controller life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
    //MARK: - Back to dashboard button action
    @IBAction func BackButtonAction(_ sender: MyButton) {
        let vc = ProductsVC(nibName: "ProductsVC", bundle: nil)
        self.RootViewControllerWithNav(vc)
    }
    
}
