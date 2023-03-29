//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

final class FoodModel {
    
    private let dataLoader: DataLoader
    
    var items: [Item] = []
    
    init(dataLoader: DataLoader) {
        self.dataLoader = dataLoader
        fakeData()
    }
    
    private func fakeData() {
        let item1 = Item(name: "Apple", countValue: 0, isSet: false, isBought: false, typeFood: .fruits)
        let item2 = Item(name: "Cherry", countValue: 0, isSet: false, isBought: false, typeFood: .fruits)
        let item3 = Item(name: "Cucumber", countValue: 0, isSet: false, isBought: false, typeFood: .vegetables)
        let item4 = Item(name: "Strawberry", countValue: 0, isSet: false, isBought: false, typeFood: .berries)
        items += [item1, item2, item3, item4]
    }
    
    func addToBasket(item: Item, count: Int) {
        var newItem = item
        newItem.isSet = true
        newItem.countValue = count
        if let index = items.firstIndex(where: { $0.name == newItem.name }) {
            items[index] = newItem
        }
    }
    
    func loadTabTitles() -> [String] {
        let nameOfFiles = dataLoader.loadNamesOfItems()
        return nameOfFiles.map( { String($0.dropLast(9)) } ).sorted(by: >)
    }
}
