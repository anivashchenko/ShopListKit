//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

extension UIButton.Configuration {
    
    static func customGroupButton(text: String, font: UIFont.TextStyle) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .lightGreen
        configuration.baseForegroundColor = .accentColor
        configuration.cornerStyle = .large
        
        var attributedString = AttributedString(text)
        attributedString.font = UIFont.preferredFont(forTextStyle: font)
        configuration.attributedTitle = attributedString
        
        return configuration
    }
    
    static func customGroupSelectedButton(text: String, font: UIFont.TextStyle) -> UIButton.Configuration {
        var configuration = customGroupButton(text: text, font: font)
        configuration.background.backgroundColor = .accentColor
        configuration.baseForegroundColor = .white
        return configuration
    }
}
