//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

extension UIButton.Configuration {
    
    static let customGroupButton: UIButton.Configuration = {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = UIColor(Color.lightGreen)
        configuration.baseForegroundColor = UIColor(Color.darkGreen)
        configuration.cornerStyle = .large
        return configuration
    }()
    
    static let customGroupSelectedButton: UIButton.Configuration = {
        var configuration = customGroupButton
        configuration.background.backgroundColor = UIColor(Color.darkGreen)
        configuration.baseForegroundColor = .white
        return configuration
    }()
}
