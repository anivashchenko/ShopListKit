//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct BasketItem: Identifiable, Equatable {
    
    var name: String
    var countValue: Int
    var typeFood: Item.TypeFood
    var isAddedToList: Bool = true
    var isBought: Bool = false
    var isFavorite: Bool = false
    
    var id: String {
        get { name + "\(isAddedToList)" }
    }
    
    mutating func updateIsAddedAndIsBought() {
        isAddedToList.toggle()
        isBought.toggle()
    }
    
    mutating func updateIsFavorite() {
        isFavorite.toggle()
    }
}
