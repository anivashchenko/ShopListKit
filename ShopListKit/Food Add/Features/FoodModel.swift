//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodModel {
    
    var items: [Item] = []
    
    init() {
        fakeData()
    }
    
    private func fakeData() {
        let item1 = Item(name: "Apple", countValue: 0, isSet: false, isBought: false, typeFood: .fruits)
        let item2 = Item(name: "Cherry", countValue: 0, isSet: false, isBought: false, typeFood: .fruits)
        let item3 = Item(name: "Cucumber", countValue: 0, isSet: false, isBought: false, typeFood: .vegetables)
        let item4 = Item(name: "Strawberry", countValue: 0, isSet: false, isBought: false, typeFood: .berries)
        items += [item1, item2, item3, item4]
    }
}
