//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class EmptyBasketView: UIView {
    
    @IBOutlet var basketImageView: UIImageView!
    
    private static let reuseIdentifier = String(describing: EmptyBasketView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let _ = loadNibNamed()
        
        let height = basketImageView.frame.height
        basketImageView.image = UIImage.imageFromBezierPath(
            .basketBezierPath(height: height),
            size: CGSize(width: height, height: height),
            color: UIColor(.darkGreen).cgColor)
    }
}
