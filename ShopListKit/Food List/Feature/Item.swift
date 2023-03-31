//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct Item: Codable, Identifiable {
    
    let id = UUID().uuidString
    let name: String
    var countValue: Int
    var isSet: Bool
    var isBought: Bool
    let typeFood: TypeFood

    enum TypeFood: String, Codable {
        case vegetables, fruits, berries
    }
    
    private enum CodingKeys: CodingKey {
        case name, countValue, isSet, isBought, typeFood
    }
    
    func addNewItem(with count: Int) -> Item {
        Item(name: name, countValue: count, isSet: true, isBought: false, typeFood: typeFood)
    }
}
