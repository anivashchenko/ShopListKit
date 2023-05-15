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
        
        view.configureView(name: item.name, count: item.countValue)
        didPressAddButton(from: view)
        
        return view
    }
    
    private func didPressAddButton(from view: FoodAddRect) {
        view.onPressAddToBasketButton = { [weak self] count in
            guard let self else { return }
            
            self.foodModel.addToBasket(item: self.item!, count: count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
