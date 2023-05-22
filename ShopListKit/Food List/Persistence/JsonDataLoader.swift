//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class JSONDataLoader: DataLoader {
    
    var titles: [String] = []
    
    func loadData() -> [FoodListItem] {
        loadNamesOfFiles()
        var items: [FoodListItem] = []
        titles.forEach {
            let loadedItems = load("\($0)Data.json") as [FoodListItem]
            items.append(contentsOf: loadedItems)
        }
        
        return items
    }
    
    private func loadNamesOfFiles() {
        guard let path = Bundle.main.resourcePath,
              let files = try? FileManager.default.contentsOfDirectory(atPath: path)
        else { return }
        
        for file in files where file.hasSuffix("json") {
            let title = String(file.dropLast(9))
            titles.append(title)
        }
    }
}
