//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class FoodAddViewController: UIViewController {
    
    @IBOutlet var foodAddView: UIView!
    @IBOutlet var backgroundImage: UIImageView!
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = foodAddView as? FoodAddRect {
            view.titleLabel.attributedText = customAttributedTitle(item.name, size: 30, color: .darkGreen)
            view.imageView?.image = UIImage(named: item.name)
        }
        
        backgroundImage.image = UIImage(named: item.name)
        blurBackGroundImage()
    }
    
    private func blurBackGroundImage() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
}
