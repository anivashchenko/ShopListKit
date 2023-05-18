//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var foodAddView: UIView!
    
    var foodModel: FoodListModel!
    var item: FoodListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let customView = loadAddItemView() else { return }
        view.addSubview(customView)
        
        backgroundImage.image = UIImage(named: item.name)
        blurBackgroundImage(for: backgroundImage)
    }
    
    private func loadAddItemView() -> UIView? {
        guard let view = foodAddView as? AddItemView else { return nil }
        
        view.configureView(name: item.name, count: item.countValue)
        didPressAddButton(from: view)
        
        return view
    }
    
    private func didPressAddButton(from view: AddItemView) {
        view.onPressAddToBasketButton = { [weak self] count in
            guard let self else { return }
            
            self.foodModel.addToBasket(item: self.item!, count: count)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
