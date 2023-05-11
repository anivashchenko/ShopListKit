//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

protocol CountStepperDelegate: AnyObject {
    func configureAddToBasketButton(_ view: UIView, count: Int)
}

class CountStepper: UIView {
    
    @IBOutlet var count: UILabel!
    @IBOutlet private var minusButton: UIButton!
    @IBOutlet private var plusButton: UIButton!
    
    weak var delegate: CountStepperDelegate?
    
    private static let reuseIdentifier = String(describing: CountStepper.self)
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
        let view = loadNibNamed()
        view.layer.cornerRadius = 15
        
        plusButton.setAttributedTitle(.customAttributedTitle("+", size: 35), for: .normal)
        count.attributedText = .customAttributedTitle("0", size: 35)
        minusButton.setAttributedTitle(.customAttributedTitle("-", size: 35), for: .normal)
    }
    
    @IBAction func didPressMinus(_ sender: UIButton) {
        incrementor(number: -1)
    }
    
    @IBAction func didPressPlus(_ sender: UIButton) {
        incrementor(number: 1)
    }
    
    private func incrementor(number: Int) {
        guard let countFromLabel = Int(count.text!) else { return }
        
        countInt = countFromLabel + number
        if onEnabled() {
            count.text = "\(countInt)"
        }
        
        delegate?.configureAddToBasketButton(self, count: countInt)
    }
    
    private func onEnabled() -> Bool {
        let isEnabled = !(countInt == -1)
        minusButton.isEnabled = isEnabled
        
        return isEnabled
    }
}
