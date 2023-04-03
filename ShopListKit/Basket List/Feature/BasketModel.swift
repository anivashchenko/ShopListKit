//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {
    
    private var items: [BasketItem] {
        didSet {
            updateAddedItem()
            updateBoughtItem()
        }
    }
    
    var addedItem: [BasketItem]
    var boughtItem: [BasketItem]
    
    init() {
        self.items = []
        self.addedItem = []
        self.boughtItem = []
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
        items[indexForChanging] = item.updateCount(with: count)
        items.remove(at: indexForRemoving)
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
