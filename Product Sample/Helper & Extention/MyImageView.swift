import UIKit

class MyImageView: UIImageView {
    
    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            setCornerRadious()
        }
    }
    func setCornerRadious(){
        self.layer.cornerRadius = cornerRadious
        
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            setBorderColor()
        }
    }
    @IBInspectable var BorderWidth: CGFloat = 0 {
        didSet {
            setBorderColor()
        }
    }
    func setBorderColor(){
        
        self.layer.borderColor = BorderColor.cgColor
        self.layer.borderWidth = BorderWidth
        
    }
    
}
