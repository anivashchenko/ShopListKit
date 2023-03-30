//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

class JsonDataLoader: DataLoader {
    
    var titles: [String] = []
    
    func loadData() -> [Item] {
        loadNamesOfFiles()
        var items: [Item] = []
        titles.forEach {
            let loadItems: [Item] = load("\($0)Data.json")
            items.append(contentsOf: loadItems)
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
    
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle: \n\(error.localizedDescription)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
