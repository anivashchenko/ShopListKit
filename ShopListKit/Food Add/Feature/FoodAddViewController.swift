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
            view.stepper.delegate = self
            changeBackgroundColor(view, count: 0)
            view.onPressAddButton = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        backgroundImage.image = UIImage(named: item.name)
        blurBackgroundImage(for: backgroundImage)
    }
}

// Count Stepper Delegate
extension FoodAddViewController: CountStepperDelegate {
    
    func changeBackgroundColor(_ view: UIView, count: Int) {
        if let view = foodAddView as? FoodAddRect, let button = view.addButton {
            button.backgroundColor = count > 0 ? UIColor(.darkGreen) : .lightGray
        }
    }
}
