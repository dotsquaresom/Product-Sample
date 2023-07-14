//
//  BaseViewController.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class BaseViewController: UIViewController {

    var Notification_Button = MIBadgeButton()
    var Notifibutton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Hide back button title
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = ""
        navigationItem.backBarButtonItem = backBarBtnItem
        
        //MARK: - Add Navigation bar right button
        
        let rightImage = UIImage(named: "cart")
        let rightFrameimg = CGRect(x: 0, y: 0,width: 30,height: 30)
        self.Notification_Button.frame = rightFrameimg
        self.Notification_Button.setImage(rightImage, for: UIControl.State())
        self.Notification_Button.badgeTextColor = .white
        self.Notification_Button.badgeEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        self.Notification_Button.badgeBackgroundColor = .red
        self.Notification_Button.backgroundColor = .clear
        self.Notification_Button.addTarget(self, action: #selector(self.CartButtonAction), for: UIControl.Event.touchUpInside)
        
        self.Notifibutton.customView = self.Notification_Button
        self.navigationItem.rightBarButtonItem = self.Notifibutton
    }
    @objc func CartButtonAction(_ sender: ResponsiveButton){
        //        let filter = Config.ProductList.filter {($0.Quentity ?? 0 > 0)}
        let vc = MyCartVC(nibName: "MyCartVC", bundle: nil)
        self.onlyPushViewController(vc)
    }

}
