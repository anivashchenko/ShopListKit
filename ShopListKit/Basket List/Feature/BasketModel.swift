//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class BasketModel {

    var items: [BasketItem]
    
    init() {
        self.items = []
    }
    
    func updateItem(_ item: BasketItem) {
        guard let index = items.firstIndex(where: { $0.name == item.name }) else { return }
        items[index] = item
    }
}
