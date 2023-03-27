//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class FoodAddViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var foodAddView: UIView!
    
    var foodModel: FoodModel!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = foodAddView as? FoodAddRect {
            view.titleLabel.attributedText = customAttributedTitle(item.name, size: 30, color: .darkGreen)
            view.imageView?.image = UIImage(named: item.name)
            view.stepper.delegate = self
            
            if let item = foodModel.items.first(where: { $0.name == item.name }) {
                let countValue = item.countValue
                view.stepper.count.text = "\(countValue)"
                changeBackgroundColor(view, count: countValue)
            }
            
            view.onPressAddButton = { [weak self] count in
                guard let self = self else { return }
                
                self.foodModel.addToBasket(item: self.item!, count: count)
                self.navigationController?.popViewController(animated: true)
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
