//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIButton {
    
    static func configurationHandler(for buttons: [UIButton?], titles: [String]) -> UIButton.ConfigurationUpdateHandler {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            guard titles.count == buttons.count,
                  let index = buttons.firstIndex(where: { $0 == button })
            else { return }
            
            switch button.state {
            case .selected, .highlighted:
                button.configuration = .customGroupButton(text: titles[index], font: .body)
            default:
                button.configuration = .customGroupSelectedButton(text: titles[index], font: .body)
            }
        }
        
        return handler
    }
}
