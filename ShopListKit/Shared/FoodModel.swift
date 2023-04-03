//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

final class FoodModel {
    
    private(set) var currentItems: [Item]
    private var items: [Item]
    private var titles: [String]
    
    var basketModel: BasketModel
    
    init(items: [Item], titles: [String], basketModel: BasketModel) {
        self.items = items
        self.titles = titles
        self.currentItems = []
        self.basketModel = basketModel
        
        basketModel.onDeleteAllItems = resetAllAddedItems
    }
    
    func addToBasket(item: Item, count: Int) {
        let newItem = item.addNewItem(with: count)
        if let index = items.firstIndex(where: { $0.name == newItem.name }) {
            items[index] = newItem
            filterCurrentItems(of: item.typeFood.rawValue) {}
            
            let basketItem = BasketItem(name: newItem.name, countValue: newItem.countValue, isAddedToList: true, isBought: false, isFavorite: false, typeFood: newItem.typeFood)
            basketModel.addNewItem(basketItem)
        }
    }
    
    func loadTabTitles() -> [String] {
        titles.sorted(by: >)
    }
    
    func filterCurrentItems(of group: String, completion: () -> Void) {
        currentItems = items.filter { $0.typeFood.rawValue == group }
        completion()
    }
    
    func loadItemsWhenAppear() {
        filterCurrentItems(of: titles[0].lowercased()) {}
    }
    
    private func resetAllAddedItems() {
        var typesFood: [Item.TypeFood] = []
        
        for item in items where item.isSet == true {
            guard let index = items.firstIndex(where: { $0.name == item.name }) else { return }
            items[index] = Item.resetToDefaultItem(name: item.name, typeFood: item.typeFood)

            !typesFood.contains(item.typeFood) ? typesFood.append(item.typeFood) : nil
        }
        
        typesFood.forEach { filterCurrentItems(of: $0.rawValue) {} }
    }
}
