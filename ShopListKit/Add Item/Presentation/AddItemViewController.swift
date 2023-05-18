//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var foodAddView: AddItemView!
    
    var foodModel: FoodListModel!
    var item: FoodListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAddItemView()
        backgroundImage.image = UIImage(named: item.name)
        blurBackgroundImage(for: backgroundImage)
    }
    
    private func loadAddItemView() {
        foodAddView.configureView(name: item.name, count: item.countValue)
        didPressAddButton(from: foodAddView)
        view.addSubview(foodAddView)
    }
    
    private func didPressAddButton(from view: AddItemView) {
        view.onPressAddToBasketButton = { [weak self] count in
            guard let self, let item = self.item else { return }
            
            self.foodModel.addToBasket(item: item, count: count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
