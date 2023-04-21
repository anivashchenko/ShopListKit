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
        let configIcon = UIImage.SymbolConfiguration(paletteColors: [UIColor(.customOrange)])
        let imageIsBought = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configIcon)
        
        return isAdded ? imageIsAdded : imageIsBought
    }
    
    var attributedTitle: NSAttributedString {
        customTitleWithCount(
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
    
    private func customTitleWithCount(title: String, count: Int, size: CGFloat, primaryColor: UIColor, secondaryColor: UIColor) -> NSMutableAttributedString {
        let attrTitle = customAttributedTitle(title, size: size, color: primaryColor)
        let attrCount = customAttributedTitle(" x\(count)", size: size, color: secondaryColor)
        attrTitle.append(attrCount)
        
        return attrTitle
    }
    
    private func customAttributedTitle(_ title: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: size, weight: .semibold)
        ]
        
        return NSMutableAttributedString(string: title, attributes: attributes)
    }
}
