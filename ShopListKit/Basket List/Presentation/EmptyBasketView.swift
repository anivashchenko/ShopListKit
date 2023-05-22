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
        basketImageView.image = UIImage.basketIconImage(height: height, color: .accentColor)
        basketImageView.accessibilityIdentifier = "EmptyBasketView"
    }
}
