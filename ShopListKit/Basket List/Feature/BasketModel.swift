//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {
    
    var items: [BasketItem] {
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
    
    func updateItem(_ item: BasketItem) {
        guard let index = items.firstIndex(where: { $0.name == item.name &&
            $0.isAddedToList == item.isAddedToList })
        else { return updateAddedBoughtItem(item) }
        items[index] = item
    }
    
    private func updateAddedItem() {
        addedItem = items.filter { $0.isAddedToList }
    }
    
    private func updateBoughtItem() {
        boughtItem = items.filter { $0.isBought }
    }
    
    private func updateAddedBoughtItem(_ item: BasketItem) {
        guard let index = items.firstIndex(where: { $0.name == item.name }) else { return }
        items.remove(at: index)
        items.append(item)
    }
}
