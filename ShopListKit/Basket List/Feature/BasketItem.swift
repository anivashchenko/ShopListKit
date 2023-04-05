//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct BasketItem: Identifiable {
    typealias TypeFood = Item.TypeFood
    
    var id = UUID().uuidString
    var name: String
    var countValue: Int
    var typeFood: TypeFood
    var isAddedToList: Bool
    var isBought: Bool
    var isFavorite: Bool
    
    init(name: String, countValue: Int, typeFood: TypeFood,
         isAddedToList: Bool = true, isBought: Bool = false, isFavorite: Bool = false) {
        self.name = name
        self.countValue = countValue
        self.isAddedToList = isAddedToList
        self.isBought = isBought
        self.isFavorite = isFavorite
        self.typeFood = typeFood
    }
    
    func updateCount(with oldCount: Int) -> BasketItem {
        BasketItem(
            name: name,
            countValue: countValue + oldCount,
            typeFood: typeFood,
            isAddedToList: isAddedToList,
            isBought: isBought,
            isFavorite: isFavorite)
    }
    
    func updateIsBought() -> BasketItem {
        BasketItem(
            name: name,
            countValue: countValue,
            typeFood: typeFood,
            isAddedToList: !isAddedToList,
            isBought: !isBought,
            isFavorite: isFavorite)
    }
}
