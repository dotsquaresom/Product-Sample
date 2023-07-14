//
//  CartTableCell.swift
//  Product Sample
//
//  Created by OmPrakash Jangid on 13/07/23.
//

import UIKit

class CartTableCell: UITableViewCell {

    @IBOutlet weak var ImgView: MyImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var BrandLbl: UILabel!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ProductValueLbl: UILabel!
    @IBOutlet weak var PlusButton: ResponsiveButton!
    @IBOutlet weak var MinusButton: ResponsiveButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
