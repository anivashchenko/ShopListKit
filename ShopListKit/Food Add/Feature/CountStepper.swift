//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class CountStepper: UIView {

    @IBOutlet var count: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!

    private static let reuseIdentifier = "CountStepper"
    private var countInt = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed(CountStepper.reuseIdentifier, owner: self, options: nil)?.first as? UIView else {
            fatalError("Couldn't load CountStepper")
        }
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.cornerRadius = 15

        plusButton.setAttributedTitle(customAttributedTitle("+", size: 35, color: .white), for: .normal)
        count.attributedText = customAttributedTitle("0", size: 35, color: .white)
        minusButton.setAttributedTitle(customAttributedTitle("-", size: 35, color: .white), for: .normal)
    }
    
    @IBAction func didPressMinus(_ sender: UIButton) {
        incrementor(number: -1)
    }
    
    @IBAction func didPressPlus(_ sender: UIButton) {
        incrementor(number: 1)
    }
    
    private func incrementor(number: Int) {
        if onEnabled() || number > 0 {
            countInt = Int(count.text!)! + number
            count.text = "\(countInt)"
        }
    }
    
    private func onEnabled() -> Bool {
        let isEnabled = !(countInt == 0)
        minusButton.isEnabled = isEnabled
        return isEnabled
    }
}
