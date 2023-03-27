//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func blurBackgroundImage(for image: UIImageView) {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = image.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.addSubview(blurEffectView)
    }
}
