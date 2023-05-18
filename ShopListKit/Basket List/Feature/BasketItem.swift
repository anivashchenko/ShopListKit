//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct BasketItem: Equatable, Identifiable {
    
    let name: String
    let typeFood: FoodListItem.TypeFood
    var count: Int
    var isAddedToBasket = true
    var isBought = false
    var isFavorite = false
    
    var id: String { name + "\(isAddedToBasket)" }
    
    mutating func updateIsAddedAndIsBought() {
        isAddedToBasket.toggle()
        isBought.toggle()
    }
    
    mutating func updateIsFavorite() {
        isFavorite.toggle()
    }
}
