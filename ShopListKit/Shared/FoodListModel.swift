//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

final class FoodListModel {
    
    private(set) var currentItems: [FoodListItem]
    private var items: [FoodListItem]
    private var titles: [String]
    
    var basketModel: BasketModel
    
    init(items: [FoodListItem], titles: [String], basketModel: BasketModel) {
        self.items = items
        self.titles = titles
        self.currentItems = []
        self.basketModel = basketModel
        
        basketModel.onDelete = resetItem
        basketModel.onDeleteAllItems = resetAllAddedItems
    }
    
    func addToBasket(item: FoodListItem, count: Int) {
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
    
    func viewModelForItem(at row: Int) -> FoodListCellViewModel {
        let item = currentItems[row]
        
        return FoodListCellViewModel(name: item.name, count: item.countValue)
    }
    
    private func resetAllAddedItems() {
        var typesFood: [FoodListItem.TypeFood] = []
        
        items.filter { $0.isSet == true }
             .forEach {
                resetToDefaultItem(with: $0.name, from: $0.typeFood)
                !typesFood.contains($0.typeFood) ? typesFood.append($0.typeFood) : nil
             }
        
        typesFood.forEach { filterCurrentItems(of: $0.rawValue) {} }
    }
    
    private func resetItem(with name: String, from typeFood: FoodListItem.TypeFood) {
        resetToDefaultItem(with: name, from: typeFood)
        filterCurrentItems(of: typeFood.rawValue) {}
    }
    
    private func resetToDefaultItem(with name: String, from typeFood: FoodListItem.TypeFood) {
        guard let index = items.firstIndex(where: { $0.name == name }) else { return }
        items[index] = FoodListItem.resetToDefaultItem(name: name, typeFood: typeFood)
    }
}