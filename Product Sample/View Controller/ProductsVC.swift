//
//  ProductsVC.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class ProductsVC: BaseViewController {
    
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    var ProductModel = ProdcutViewModel()
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All Product's"
        
        self.ProductModel.delegate = self
        
        Config().collectionViewLoad(collection: self.ProductCollectionView,
                                    nibName: "ProductCollectionCell",
                                    itemWidth: Int(Config().screenWidth)/2-16,
                                    itemHeight: Int(Config().screenWidth/1.5),
                                    minimumLineSpacing: 10,
                                    scrollDirection: .vertical)
        
        self.ProductModel.getProductListAPI(param: [:])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ProductCollectionView.reloadData()
    }
    
}

extension ProductsVC: UICollectionViewDataSource{
    //MARK: - Collection view delegate & data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let badgeCount = Config.ProductList.filter{($0.Quentity ?? 0 > 0)}.count
        self.Notification_Button.badgeString = "\(badgeCount)"
        return Config.ProductList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        
        let dict = Config.ProductList[indexPath.row]
        
        Config().setimage(image_url: dict.thumbnail ?? "", image_name: cell.ImgView)
        cell.TitleLbl.text = dict.title
        cell.PriceLbl.text = "$\(dict.price ?? 0)"
        cell.BrandLbl.text = dict.brand
        cell.DescLbl.text = dict.description
        
        cell.quantityView.isHidden = dict.Quentity ?? 0 > 0 ? false : true
        cell.addButton.isHidden = dict.Quentity ?? 0 > 0 ? true : false
        cell.ProductValueLbl.text = "\(dict.Quentity ?? 0)"
        
        cell.checkButton.setImage(UIImage(systemName: dict.isSelected ?? false ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        cell.PlusButton.tag = indexPath.row
        cell.PlusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        cell.MinusButton.tag = indexPath.row
        cell.MinusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        return cell
    }
    //MARK: - Collection view cell buttons action
    @IBAction func addButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList[sender.tag]
        dict.Quentity = (dict.Quentity ?? 0) + 1
        self.ProductCollectionView.reloadData()
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList[sender.tag]
        dict.Quentity = (dict.Quentity ?? 0) + 1
        dict.isSelected = dict.Quentity ?? 0 > 1 ? false : false
        self.ProductCollectionView.reloadData()
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList[sender.tag]
        dict.Quentity = (dict.Quentity ?? 0) - 1
        dict.isSelected = dict.Quentity ?? 0 == 0 ? false : false
        self.ProductCollectionView.reloadData()
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton){
        let dict = Config.ProductList[sender.tag]
        dict.isSelected = !(dict.isSelected ?? false)
        dict.Quentity = dict.isSelected ?? false ? 1 : 0
        self.ProductCollectionView.reloadData()
    }
}
//MARK: - Recive api data from delegate
extension ProductsVC: productListModelDelegate{
    func didReceiveProductResponse(response: UserList) {
        if let userData = response.products{
            DispatchQueue.main.async {
                Config.ProductList = userData
                self.ProductCollectionView.reloadData()
            }
        }
    }
}
