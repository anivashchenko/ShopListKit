//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

struct BasketCellViewModel {
    
    let name: String
    let count: Int
    let isAdded: Bool
    var isFavorite: Bool {
        didSet { onFavoriteChanged(name, isAdded) }
    }
    let onFavoriteChanged: (String, Bool) -> Void
    
    var image: UIImage? {
        let imageIsAdded = UIImage(named: name)
        let imageIsBought = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor(.customOrange))
        
        return isAdded ? imageIsAdded : imageIsBought
    }
    
    var attributedTitle: NSAttributedString {
        .customTitleWithCount(
            title: name,
            count: count,
            size: 18,
            primaryColor: isAdded ? .white : .darkGray,
            secondaryColor: isAdded ? .lightGray : .gray
        )
    }
    
    var starImageColor: UIColor {
        isFavorite ? .systemYellow : UIColor(.lightGray)
    }
    
    var backgroundColor: UIColor {
        isAdded ? UIColor(.darkGreen) : UIColor(.lightGreen)
    }
}
