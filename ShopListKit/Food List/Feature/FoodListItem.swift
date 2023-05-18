//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct FoodListItem: Codable, Identifiable {
    
    let name: String
    let typeFood: TypeFood
    var count = 0
    var isSet = false
    
    var id: String { name }
    
    enum TypeFood: String, Codable {
        case vegetables, fruits, berries
    }
    
    private enum CodingKeys: CodingKey {
        case name, typeFood
    }
    
    func addToBasket(with count: Int) -> FoodListItem {
        FoodListItem(name: name, typeFood: typeFood, count: count, isSet: true)
    }
}
