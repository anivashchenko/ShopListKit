//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

protocol CountStepperDelegate: AnyObject {
    func configureAddToBasketButton(_ view: UIView, count: Int)
}

class CountStepperView: UIView {
    
    @IBOutlet private(set) weak var countLabel: UILabel!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    
    weak var delegate: CountStepperDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureStepperView(count: Int) {
        self.countLabel.text = String(count)
    }
    
    private func configureView() {
        let view = loadNibNamed()
        view.layer.cornerRadius = 15
        
        plusButton.setAttributedTitle(.customAttributedTitle("+", size: 35), for: .normal)
        countLabel.attributedText = .customAttributedTitle("0", size: 35)
        minusButton.setAttributedTitle(.customAttributedTitle("-", size: 35), for: .normal)
    }
    
    private func incrementor(number: Int) {
        guard let oldCount = Int(countLabel.text!) else { return }
        
        let newCount = oldCount + number
        let isEnabled = !(newCount == -1)
        if isEnabled {
            countLabel.text = "\(newCount)"
            delegate?.configureAddToBasketButton(self, count: newCount)
        }
        minusButton.isEnabled = isEnabled
    }
    
    @IBAction private func didPressMinus(_ sender: UIButton) {
        incrementor(number: -1)
    }
    
    @IBAction private func didPressPlus(_ sender: UIButton) {
        incrementor(number: 1)
    }
}
