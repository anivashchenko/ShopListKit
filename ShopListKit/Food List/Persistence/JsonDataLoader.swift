//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class JsonDataLoader: DataLoader {
    
    func loadNamesOfItems() -> [String] {
        guard let path = Bundle.main.resourcePath,
              let files = try? FileManager.default.contentsOfDirectory(atPath: path)
        else { return [] }
        
        var itemsName: [String] = []
        
        for file in files {
            if file.hasSuffix("json") {
                itemsName.append(file)
            }
        }
        
        return itemsName
    }
}
