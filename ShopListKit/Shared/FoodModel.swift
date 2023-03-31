//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

final class FoodModel {
    
    private(set) var currentItems: [Item]
    private var items: [Item]
    private var titles: [String]
    
    init(items: [Item], titles: [String]) {
        self.items = items
        self.titles = titles
        self.currentItems = []
    }
    
    func addToBasket(item: Item, count: Int) {
        let newItem = item.addNewItem(with: count)
        if let index = items.firstIndex(where: { $0.name == newItem.name }) {
            items[index] = newItem
            filterCurrentItems(of: item.typeFood.rawValue) {}
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
}
