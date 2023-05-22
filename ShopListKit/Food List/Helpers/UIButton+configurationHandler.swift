//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIButton {
    
    static func configurationHandler(for button: UIButton?, title: String) -> UIButton.ConfigurationUpdateHandler {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected, .highlighted:
                button.configuration = .customGroupButton(text: title, font: .body)
            default:
                button.configuration = .customGroupSelectedButton(text: title, font: .body)
            }
        }
        
        return handler
    }
}
