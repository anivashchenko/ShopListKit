//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class GroupTabView: UIView {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var onDidPressButton: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = loadNibNamed()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadNibNamed()
    }
    
    func configureButtons(with titles: [String]) {
        button1.isSelected = true
        let buttons = [button1, button2, button3]
        for button in buttons {
            button?.configurationUpdateHandler = getConfigurationHandler(for: buttons)
            button?.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        }
    }
    
    @objc private func didTouchUpInside(sender: UIButton) {
        let buttons = [button1, button2, button3]
        buttons.forEach({ $0?.isSelected = ($0 == sender) })
        
        if let title = sender.titleLabel?.text {
            onDidPressButton?(title)
        }
    }
    
    // MARK: - Helpers
    private func getConfigurationHandler(for buttons: [UIButton?]) -> UIButton.ConfigurationUpdateHandler {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            guard self.titles.count == buttons.count,
                  let index = buttons.firstIndex(where: { $0 == button })
            else { return }
            
            switch button.state {
            case .selected, .highlighted:
                button.configuration = .customGroupButton(text: self.titles[index], font: .body)
            default:
                button.configuration = .customGroupSelectedButton(text: self.titles[index], font: .body)
            }
        }
        
        return handler
    }
}
