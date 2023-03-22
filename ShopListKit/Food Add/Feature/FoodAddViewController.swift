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
            view.onPressAddButton = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        backgroundImage.image = UIImage(named: item.name)
        blurBackgroundImage(for: backgroundImage)
    }
}
