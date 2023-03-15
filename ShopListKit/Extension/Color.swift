//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI

extension Color {
    
    static var darkGreen: Color {
        .init("DarkGreen")
    }
    
    static var lightGreen: Color {
        .init("LightGreen")
    }
    
    static var customOrange: Color {
        .init("CustomOrange")
    }
    
    static var darkGray: Color {
        Color(uiColor: .darkGray)
    }
    
    static var lightGray: Color {
        Color(uiColor: .lightGray)
    }
    
    static var secondary: Color {
        Color(uiColor: .secondarySystemFill)
    }
}
