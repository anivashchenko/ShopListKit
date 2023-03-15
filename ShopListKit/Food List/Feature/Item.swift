//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct Item: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var countValue: Int
    var isSet: Bool
    var isBought: Bool
    var typeFood: TypeFood
   
    enum TypeFood: String {
        case fruits
        case vegetables
        case berries
    }
}
