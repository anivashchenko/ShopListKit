//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

struct Item: Identifiable {
    
    let id = UUID().uuidString
    let name: String
    var countValue: Int
    var isSet: Bool
    var isBought: Bool
    let typeFood: TypeFood

    enum TypeFood: String {
        case fruits
        case vegetables
        case berries
    }
}
