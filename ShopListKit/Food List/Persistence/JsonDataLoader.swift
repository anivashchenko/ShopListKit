//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class JsonDataLoader: DataLoader {
    
    func loadNamesOfItems() -> [String] {
        let path = Bundle.main.resourcePath!
        let files = try! FileManager.default.contentsOfDirectory(atPath: path)
        var itemsName: [String] = []
        
        for file in files {
            if file.hasSuffix("json") {
                itemsName.append(file)
            }
        }
        
        return itemsName
    }
}
