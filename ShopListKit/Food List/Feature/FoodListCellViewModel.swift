//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI

struct FoodListCellViewModel {
    let name: String
    let count: Int
    
    var attributedTitle: NSAttributedString {
        .customFoodListTitle(title: name, count: count)
    }
    
    var backgroundColor: UIColor {
        count == 0 ? .lightGray : .veryLightGreen
    }
    
    var image: UIImage? {
        UIImage(named: name)
    }
    
    var systemIcon: UIImage? {
        let configPlus = UIImage.SymbolConfiguration(hierarchicalColor: .accentColor)
        let plus = UIImage(systemName: "plus.circle.fill", withConfiguration: configPlus)
        let configCheckmark = UIImage.SymbolConfiguration(paletteColors: [.accentColor, .white])
        let checkmark = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configCheckmark)
        
        return count == 0 ? plus : checkmark
    }
}
