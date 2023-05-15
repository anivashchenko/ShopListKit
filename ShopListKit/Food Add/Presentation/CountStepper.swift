//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

protocol CountStepperDelegate: AnyObject {
    func configureAddToBasketButton(_ view: UIView, count: Int)
}

class CountStepper: UIView {
    
    @IBOutlet private(set) var count: UILabel!
    @IBOutlet private var minusButton: UIButton!
    @IBOutlet private var plusButton: UIButton!
    
    weak var delegate: CountStepperDelegate?
    
    private static let reuseIdentifier = String(describing: CountStepper.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureStepperView(count: Int) {
        self.count.text = String(count)
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
        guard let oldCount = Int(count.text!) else { return }
        
        let newCount = oldCount + number
        let isEnabled = !(newCount == -1)
        if isEnabled {
            count.text = "\(newCount)"
            delegate?.configureAddToBasketButton(self, count: newCount)
        }
        minusButton.isEnabled = isEnabled
    }
}
