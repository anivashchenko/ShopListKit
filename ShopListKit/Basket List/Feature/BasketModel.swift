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
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].countValue += item.countValue
        } else {
            items.append(item)
        }
    }
    
    func updateExistedItem(at indexPath: IndexPath) {
        var item = item(at: indexPath)
        item.updateIsAddedAndIsBought()
        addNewItem(item)
        
        if let index = items.firstIndex(where: { $0.name == item.name && $0.id != item.id }) {
            items.remove(at: index)
        }
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> BasketCellViewModel {
        let item = item(at: indexPath)
        
        return BasketCellViewModel(name: item.name, count: item.countValue, isAdded: item.isAddedToList, isFavorite: item.isFavorite) { [weak self] name, isAdded in
            guard let self else { return }
            guard let index = items.firstIndex(where: { $0.id == "\(name)\(isAdded)" }) else { return }
            items[index].updateIsFavorite()
        }
    }
    
    func currentTitle(from titles: [String], at section: Int) -> String {
        titles[section + (!addedItem.isEmpty ? 0 : 1)]
    }
    
    func moveRow(from startRow: IndexPath, to endRow: IndexPath) {
        guard startRow.section == endRow.section else { return }

        let selectedItem = viewModelForItem(at: startRow)
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
    
    private func updateAddedItem() {
        addedItem = items.filter { $0.isAddedToList }
    }
    
    private func updateBoughtItem() {
        boughtItem = items.filter { $0.isBought }
    }
    
    private func item(at indexPath: IndexPath) -> BasketItem {
        let array = sections[indexPath.section + (!addedItem.isEmpty ? 0 : 1)]
        return array[indexPath.row]
    }
}
