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
        
        basketModel.onDelete = resetItem
        basketModel.onDeleteAllItems = resetAllAddedItems
    }
    
    func addToBasket(item: Item, count: Int) {
        let newItem = item.addNewItem(with: count)
        guard let index = items.firstIndex(where: { $0.name == newItem.name }) else { return }
        items[index] = newItem
        filterCurrentItems(of: item.typeFood.rawValue) {}
        
        let basketItem = BasketItem(name: newItem.name, countValue: newItem.countValue, typeFood: newItem.typeFood)
        basketModel.addNewItem(basketItem)
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
        
        items.filter { $0.isSet == true }
             .forEach {
                resetToDefaultItem(with: $0.name, from: $0.typeFood)
                !typesFood.contains($0.typeFood) ? typesFood.append($0.typeFood) : nil
             }
        
        typesFood.forEach { filterCurrentItems(of: $0.rawValue) {} }
    }
    
    private func resetItem(with name: String, from typeFood: Item.TypeFood) {
        resetToDefaultItem(with: name, from: typeFood)
        filterCurrentItems(of: typeFood.rawValue) {}
    }
    
    private func resetToDefaultItem(with name: String, from typeFood: Item.TypeFood) {
        guard let index = items.firstIndex(where: { $0.name == name }) else { return }
        items[index] = Item.resetToDefaultItem(name: name, typeFood: typeFood)
    }
}
