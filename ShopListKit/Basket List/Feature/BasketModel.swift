//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {
    
    private var items: [BasketItem] {
        didSet {
            updateAddedItem()
            updateBoughtItem()
            sections = [addedItem, boughtItem]
        }
    }
    
    var addedItem: [BasketItem]
    var boughtItem: [BasketItem]
    var sections: [[BasketItem]]
    
    var onDelete: ((String, Item.TypeFood) -> Void)?
    var onDeleteAllItems: (() -> Void)?
    
    init() {
        self.items = []
        self.addedItem = []
        self.boughtItem = []
        self.sections = []
    }
    
    func addNewItem(_ item: BasketItem) {
        guard let index = items.firstIndex(where: { $0.name == item.name && $0.isAddedToList })
        else { return appendNewItem(item) }
        
        items[index] = item
    }
    
    func updateItem(_ item: BasketItem) {
        guard
            let indexForRemoving = items.firstIndex(where: { $0.name == item.name &&
                                                             $0.isAddedToList == item.isAddedToList }),
            let indexForChanging = items.firstIndex(where: { $0.name == item.name &&
                                                             $0.isAddedToList == !item.isAddedToList })
        else { return updateAddedBoughtItem(item) }
        
        let count = items[indexForRemoving].countValue
        items[indexForChanging].updateCount(with: count)
        items.remove(at: indexForRemoving)
    }
    
    func currentItem(at indexPath: IndexPath, updateIsBought: Bool = false) -> BasketCellViewModel {
        let array = sections[indexPath.section + (!addedItem.isEmpty ? 0 : 1)]
        var item = array[indexPath.row]
        if updateIsBought {
            item.updateIsBought()
            updateItem(item)
        }
        
        return BasketCellViewModel(name: item.name, count: item.countValue, isAdded: item.isAddedToList, isFavorite: item.isFavorite) { [weak self] name, isAdded in
            guard let self else { return }
            guard let index = items.firstIndex(where: { $0.name == name && $0.isAddedToList == isAdded }) else { return }
            items[index].updateIsFavorite()
        }
    }
    
    func currentTitle(from titles: [String], at section: Int) -> String {
        titles[section + (!addedItem.isEmpty ? 0 : 1)]
    }
    
    func moveRow(from startRow: IndexPath, to endRow: IndexPath) {
        guard startRow.section == endRow.section else { return }

        let selectedItem = currentItem(at: startRow)
        guard
            let item = items.first(where: { $0.name == selectedItem.name }),
            let index = items.firstIndex(where: { $0.name == selectedItem.name })
        else { return }
        items.remove(at: index)
        items.insert(item, at: endRow.row)
    }
    
    func removeAllItems() {
        items.removeAll()
        onDeleteAllItems?()
    }
    
    func removeItem(at indexPath: IndexPath) {
        let array = items.filter { indexPath.section == 0 ? $0.isAddedToList : $0.isBought }
        let item = array[indexPath.row]
        items.removeAll(where: { $0.name == item.name })
        onDelete?(item.name, item.typeFood)
    }
    
    private func appendNewItem(_ item: BasketItem) {
        items.append(item)
    }
    
    private func updateAddedItem() {
        addedItem = items.filter { $0.isAddedToList }
    }
    
    private func updateBoughtItem() {
        boughtItem = items.filter { $0.isBought }
    }
    
    private func updateAddedBoughtItem(_ item: BasketItem) {
        guard let index = items.firstIndex(where: { $0.name == item.name })
        else { return appendNewItem(item) }
        
        items.remove(at: index)
        items.append(item)
    }
}
