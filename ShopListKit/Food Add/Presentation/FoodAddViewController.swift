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
        
        guard let customView = loadFoodAddRectView() else { return }
        view.addSubview(customView)
        
        backgroundImage.image = UIImage(named: item.name)
        blurBackgroundImage(for: backgroundImage)
    }
    
    private func loadFoodAddRectView() -> UIView? {
        guard let view = foodAddView as? FoodAddRect else { return nil }
        
        view.titleLabel.attributedText = customAttributedTitle(item.name, size: 30, color: .darkGreen)
        view.imageView?.image = UIImage(named: item.name)
        loadCountStepperView(from: view)
        didPressAddButton(from: view)
        
        return view
    }
    
    private func loadCountStepperView(from view: FoodAddRect) {
        view.stepper.delegate = self
        
        if let item = foodModel.currentItems.first(where: { $0.name == item.name }) {
            let countValue = item.countValue
            view.stepper.count.text = "\(countValue)"
            changeBackgroundColor(view, count: countValue)
        }
    }
    
    private func didPressAddButton(from view: FoodAddRect) {
        view.onPressAddButton = { [weak self] count in
            guard let self = self else { return }
            
            self.foodModel.addToBasket(item: self.item!, count: count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
