//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {
    
    private var items: [BasketItem]
    private(set) var sections: [[BasketItem]]
    
    var onDelete: ((String, Item.TypeFood) -> Void)?
    var onDeleteAllItems: (() -> Void)?
    
    init() {
        self.items = []
        self.sections = []
    }
    
    func addNewItem(_ item: BasketItem, isUpdateSections: Bool = true) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].countValue += item.countValue
        } else {
            items.append(item)
        }
        
        isUpdateSections ? updateSections() : nil
    }
    
    func updateExistedItem(at indexPath: IndexPath) {
        var item = item(at: indexPath)
        item.updateIsAddedAndIsBought()
        addNewItem(item, isUpdateSections: false)
        
        if let index = items.firstIndex(where: { $0.name == item.name && $0.id != item.id }) {
            items.remove(at: index)
        }
        updateSections()
    }
    
    func moveRow(from startRow: IndexPath, to endRow: IndexPath) {
        guard startRow.section == endRow.section else { return }
        
        let itemStart = item(at: startRow)
        let itemEnd = item(at: endRow)
        if let indexStart = items.firstIndex(where: { $0.id == itemStart.id }),
           let indexEnd = items.firstIndex(where: { $0.id == itemEnd.id }) {
            let item = items[indexStart]
            items.remove(at: indexStart)
            items.insert(item, at: indexEnd)
            updateSections()
        }
    }
    
    func removeAllItems() {
        items.removeAll()
        updateSections()
        onDeleteAllItems?()
    }
    
    func removeItem(at indexPath: IndexPath) {
        let item = item(at: indexPath)
        items.removeAll(where: { $0.id == item.id })
        updateSections()
        onDelete?(item.name, item.typeFood)
    }
    
    func titleForHeader(in section: Int) -> String {
        let titles = ["WANT TO BUY:", "BOUGHT:"]
        let isAddedItemExist = items.first { $0.isAddedToList } != nil
        return titles[section + (isAddedItemExist ? 0 : 1)]
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> BasketCellViewModel {
        let item = item(at: indexPath)
        
        return BasketCellViewModel(name: item.name, count: item.countValue, isAdded: item.isAddedToList, isFavorite: item.isFavorite) { [weak self] name, isAdded in
            guard let self else { return }
            guard let index = items.firstIndex(where: { $0.id == "\(name)\(isAdded)" }) else { return }
            items[index].updateIsFavorite()
        }
    }
    
    private func item(at indexPath: IndexPath) -> BasketItem {
        sections[indexPath.section][indexPath.row]
    }
    
    private func updateSections() {
        let addedItem = items.filter { $0.isAddedToList }
        let boughtItem = items.filter { $0.isBought }
        sections = [addedItem, boughtItem]
        sections.removeAll(where: { $0.isEmpty })
    }
}
