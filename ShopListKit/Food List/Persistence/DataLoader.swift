//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import Foundation

protocol DataLoader {
    var titles: [String] { get }
    
    func loadData() -> [FoodListItem]
}
