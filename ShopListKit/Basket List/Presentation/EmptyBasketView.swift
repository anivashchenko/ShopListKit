//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class EmptyBasketView: UIView {
    
    @IBOutlet var basketImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let _ = loadNibNamed()
        
        let height = basketImageView.frame.height
        basketImageView.image = UIImage.imageFromBezierPath(
            .basketBezierPath(height: height),
            size: CGSize(width: height, height: height),
            color: UIColor.accentColor.cgColor)
        basketImageView.accessibilityIdentifier = "EmptyBasketView"
    }
}
