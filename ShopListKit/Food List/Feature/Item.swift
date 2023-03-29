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
        case fruits
        case vegetables
        case berries
    }
    
    enum CodingKeys: CodingKey {
        case name
        case countValue
        case isSet
        case isBought
        case typeFood
    }
}
