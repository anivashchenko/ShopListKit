//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

final class FoodListModel {
    
    private(set) var currentItems: [FoodListItem]
    private var items: [FoodListItem]
    private var titles: [String]
    
    var basketModel: BasketModel
    var onDataChanged: (() -> Void)?
    
    init(items: [FoodListItem], titles: [String], basketModel: BasketModel) {
        self.items = items
        self.titles = titles
        self.currentItems = []
        self.basketModel = basketModel
        
        basketModel.onDelete = resetItem
        basketModel.onDeleteAllItems = resetAllAddedItems
    }
    
    func addToBasket(item: FoodListItem, count: Int) {
        guard let index = items.firstIndex(where: { $0.name == item.name }) else { return }
        items[index] = item.addToBasket(with: count)
        filterCurrentItems(of: item.typeFood.rawValue)
        
        let basketItem = BasketItem(name: item.name, typeFood: item.typeFood, count: item.count + count)
        basketModel.addNewItem(basketItem)
    }
    
    func loadTabTitles() -> [String] {
        titles.sorted(by: >)
    }
    
    func filterCurrentItems(of group: String) {
        currentItems = items.filter { $0.typeFood.rawValue == group }
        onDataChanged?()
    }
    
    func loadItemsWhenAppear() {
        filterCurrentItems(of: titles[0].lowercased())
    }
    
    func viewModelForItem(at row: Int) -> FoodListCellViewModel {
        let item = currentItems[row]
        
        return FoodListCellViewModel(name: item.name, count: item.count)
    }
    
    private func resetAllAddedItems() {
        var typesFood: [FoodListItem.TypeFood] = []
        items.filter { $0.isSet == true }
             .forEach {
                resetToDefaultItem(with: $0.name, from: $0.typeFood)
                !typesFood.contains($0.typeFood) ? typesFood.append($0.typeFood) : nil
             }
        
        typesFood.forEach { filterCurrentItems(of: $0.rawValue) }
    }
    
    private func resetItem(with name: String, from typeFood: FoodListItem.TypeFood) {
        resetToDefaultItem(with: name, from: typeFood)
        filterCurrentItems(of: typeFood.rawValue)
    }
    
    private func resetToDefaultItem(with name: String, from typeFood: FoodListItem.TypeFood) {
        guard let index = items.firstIndex(where: { $0.name == name }) else { return }
        items[index] = FoodListItem(name: name, typeFood: typeFood)
    }
}
