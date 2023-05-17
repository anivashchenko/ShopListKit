//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct FoodListItem: Codable, Identifiable {
    
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
    
    static func resetToDefaultItem(name: String, typeFood: TypeFood) -> FoodListItem {
        FoodListItem(name: name, countValue: 0, isSet: false, isBought: false, typeFood: typeFood)
    }
    
    func addNewItem(with count: Int) -> FoodListItem {
        FoodListItem(name: name, countValue: count, isSet: true, isBought: false, typeFood: typeFood)
    }
}
