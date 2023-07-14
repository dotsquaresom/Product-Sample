//
//  MyCartVC.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class MyCartVC: UIViewController {
    
    @IBOutlet weak var CartTblView: UITableView!
    @IBOutlet weak var PlaceOrderView: MyView!
    @IBOutlet weak var PlaceOrderViewHeightConstraint: NSLayoutConstraint!//70
    
    //var cartArray = [Product]()
    
    //MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Cart"
        
        Config().tableViewLoad(tbl: self.CartTblView, nibName: "CartTableCell")
    }
    
    @IBAction func PlaceOrderButtonAction(_ sender: UIButton) {
        let vc = SuccessVC(nibName: "SuccessVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    //MARK: - Place order view animation
    func set_frame_of_PlaceOrderView(hidden_type: Bool, constant: CGFloat){
        self.PlaceOrderView.isHidden = hidden_type
        self.PlaceOrderViewHeightConstraint.constant = constant
        UIView.animate(withDuration: 0.5) {
            self.PlaceOrderView.layoutIfNeeded()
        }
    }
}
//MARK: - Tableview data source
extension MyCartVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cartCount = Config.ProductList.filter{($0.Quentity ?? 0 > 0)}.count
        print("cartCount",cartCount)
        if cartCount == 0{
            self.set_frame_of_PlaceOrderView(hidden_type: true, constant: 0)
            Config().TblViewbackgroundLbl(tblName: self.CartTblView, message: "No products available in your cart")
        }else{
            self.set_frame_of_PlaceOrderView(hidden_type: false, constant: 70)
            self.CartTblView.backgroundView = nil
        }
        return cartCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableCell", for: indexPath) as! CartTableCell
        let dict =  Config.ProductList.filter{($0.Quentity ?? 0 > 0)}[indexPath.row]
        
        Config().setimage(image_url: dict.thumbnail ?? "", image_name: cell.ImgView)
        cell.TitleLbl.text = dict.title
        cell.PriceLbl.text = "$\(dict.price ?? 0)"
        cell.BrandLbl.text = dict.brand
        cell.DescLbl.text = dict.description
        
        cell.ProductValueLbl.text = "\(dict.Quentity ?? 0)"
        
        cell.PlusButton.tag = indexPath.row
        cell.PlusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        cell.MinusButton.tag = indexPath.row
        cell.MinusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        return cell
    }
    //MARK: - Table view cell buttons action
    @IBAction func plusButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList.filter{($0.Quentity ?? 0 > 0)}[sender.tag]
        dict.Quentity = (dict.Quentity ?? 0) + 1
        dict.isSelected = dict.Quentity ?? 0 > 1 ? false : false
        self.CartTblView.reloadData()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList.filter{($0.Quentity ?? 0 > 0)}[sender.tag]
        dict.Quentity = (dict.Quentity ?? 0) - 1
        dict.isSelected = dict.Quentity ?? 0 == 0 ? false : false
        self.CartTblView.reloadData()
    }
    
}
