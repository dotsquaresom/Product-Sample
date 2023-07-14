//
//  ProductCollectionCell.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ImgView: MyImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var BrandLbl: UILabel!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityView : UIView!
    @IBOutlet weak var ProductValueLbl: UILabel!
    @IBOutlet weak var PlusButton: ResponsiveButton!
    @IBOutlet weak var MinusButton: ResponsiveButton!
    @IBOutlet weak var checkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
