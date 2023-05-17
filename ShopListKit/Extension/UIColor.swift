//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI

extension UIColor {
    
    static var accentColor: UIColor {
        UIColor(Color("AccentColor"))
    }
    
    static var customOrange: UIColor {
        UIColor(Color("CustomOrange"))
    }
    
    static var lightGray: UIColor {
        .secondarySystemFill
    }
    
    static var lightGreen: UIColor {
        UIColor(Color("LightGreen"))
    }
    
    static var veryLightGreen: UIColor {
        .lightGreen.withAlphaComponent(0.3)
    }
}
