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
        guard buttons.count == titles.count else { return }
        
        buttons.indices.forEach {
            buttons[$0]?.configurationUpdateHandler = UIButton.configurationHandler(for: buttons[$0], title: titles[$0])
            buttons[$0]?.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        }
    }
    
    @objc private func didTouchUpInside(sender: UIButton) {
        let buttons = [button1, button2, button3]
        buttons.forEach({ $0?.isSelected = ($0 == sender) })
        
        if let title = sender.titleLabel?.text {
            onDidPressButton?(title)
        }
    }
}
