//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct BasketItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var countValue: Int
    var isAddedToList: Bool
    var isBought: Bool
    var isFavorite: Bool
    var typeFood: Item.TypeFood
    
    func updateCount(with oldCount: Int) -> BasketItem {
        BasketItem(
            name: name,
            countValue: countValue + oldCount,
            isAddedToList: isAddedToList,
            isBought: isBought,
            isFavorite: isFavorite,
            typeFood: typeFood)
    }
    
    func updateIsBought() -> BasketItem {
        BasketItem(
            name: name,
            countValue: countValue,
            isAddedToList: !isAddedToList,
            isBought: !isBought,
            isFavorite: isFavorite,
            typeFood: typeFood)
    }
}
