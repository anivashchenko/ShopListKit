//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct BasketItem: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var countValue: Int
    var typeFood: Item.TypeFood
    var isAddedToList: Bool = true
    var isBought: Bool = false
    var isFavorite: Bool = false
    
    mutating func updateCount(with oldCount: Int) {
        countValue += oldCount
        updateIsBought()
    }
    
    mutating func updateIsBought() {
        isAddedToList.toggle()
        isBought.toggle()
    }
}
