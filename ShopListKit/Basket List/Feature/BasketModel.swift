//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {

    var items: [BasketItem]
    
    init() {
        self.items = []
        fakeData()
    }
    
    private func fakeData() {
        let item1 = BasketItem(name: "Apple", countValue: 3, isAddedToList: true, isBought: false, isFavorite: false, typeFood: .fruits)
        let item2 = BasketItem(name: "Cherry", countValue: 1, isAddedToList: true, isBought: false, isFavorite: true, typeFood: .fruits)
        let item3 = BasketItem(name: "Cucumber", countValue: 1, isAddedToList: false, isBought: true, isFavorite: false, typeFood: .vegetables)
        let item4 = BasketItem(name: "Strawberry", countValue: 2, isAddedToList: false, isBought: true, isFavorite: false, typeFood: .fruits)
        items += [item1, item2, item3, item4]
    }
}
