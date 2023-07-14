import Foundation
import UIKit
import SDWebImage
import SVProgressHUD

class Config: NSObject,UIAlertViewDelegate {
    
    var API_URL = "https://dummyjson.com/products"
    static var ProductList = [Product]()
    let AppAlertTitle = "Product Sample"
    let AppUserDefaults = UserDefaults.standard
    let debug_mode = 1
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    /********************************* App Color Codes ***************************************/
    
    let AppNavColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    let AppNavTextColor = UIColor(red: 238.0/255.0, green: 94.0/255.0, blue: 132.0/255.0, alpha: 1.0)
    
    static func showHud(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    static func dissmissHud(){
        SVProgressHUD.dismiss()
    }
    static func showHudWithStatus(status: String){
        SVProgressHUD.show(withStatus: status)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    func printData(_ dataValue : Any ){
        if debug_mode == 1 {
            print(dataValue)
        }
    }
    func getWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                return nil
            }
            return window
        } else {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow
        }
    }
    func collectionViewLoad(collection: UICollectionView, nibName: String, itemWidth: Int, itemHeight: Int, minimumLineSpacing: CGFloat, scrollDirection: UICollectionView.ScrollDirection){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = scrollDirection
        
        
        let nib = UINib(nibName: nibName, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: nibName)
        collection.reloadData()
        collection.collectionViewLayout = layout
    }
    func tableViewLoad(tbl: UITableView, nibName: String){
        let nib = UINib(nibName: nibName, bundle: nil)
        tbl.register(nib, forCellReuseIdentifier: nibName)
        tbl.rowHeight = UITableView.automaticDimension
        tbl.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            tbl.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    func TblViewbackgroundLbl(tblName: UITableView, message: String){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tblName.frame.size.width, height: tblName.frame.size.height))
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = message
        tblName.backgroundView = label
    }
    func CollectionViewbackgroundLbl(array: [Any], collectionName: UICollectionView, message: String){
        collectionName.reloadData()
        if array.count > 0{
            collectionName.backgroundView = nil
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: collectionName.frame.size.width, height: collectionName.frame.size.height))
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
            label.textAlignment = .center
            label.text = message
            label.numberOfLines = 2
            collectionName.backgroundView = label
        }
    }
    func setimage(image_url: String,image_name: UIImageView){
        if image_url != ""{
            let Indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            Indicator.center = (image_name.center)
            Indicator.hidesWhenStopped = true
            Indicator.startAnimating()
            let picture_url: URL = URL(string: image_url)!
            image_name.addSubview(Indicator)
            image_name.sd_setImage(with: picture_url , placeholderImage: UIImage(named: "Loading"), options:  [], completed: { image, error, cacheType, imageURL in
                Indicator.stopAnimating()
            })
        }else{
            image_name.image = UIImage(named: "NoImage")
        }
    }
}
