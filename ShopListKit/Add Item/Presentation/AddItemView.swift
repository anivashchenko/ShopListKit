//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class AddItemView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var stepper: CountStepperView!
    @IBOutlet private weak var addToBasketButton: UIButton!
    
    var onPressAddToBasketButton: ((Int) -> Void)?
    
    private let addedToBasketView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView(name: String, count: Int) {
        titleLabel.attributedText = .customAttributedTitle(name, size: 30, color: .accentColor)
        imageView.image = UIImage(named: name)
        stepper.delegate = self
        stepper.configureStepperView(count: count)
        configureAddToBasketButton(self, count: count)
    }
    
    private func configureView() {
        let _ = loadNibNamed()
        
        titleView.layer.cornerRadius = 15
        configureAddToBasketButton()
        configureAddedToBasketSubview()
        layer.cornerRadius = 15
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
    }
    
    private func configureAddedToBasketSubview() {
        let addedToBasketLabel = UILabel()
        addedToBasketLabel.translatesAutoresizingMaskIntoConstraints = false
        addedToBasketLabel.attributedText = .customAttributedTitle("Succesfully added to the basket!", size: 18)
        addedToBasketLabel.textAlignment = .center
        
        addedToBasketView.layer.cornerRadius = 15
        addedToBasketView.backgroundColor = .accentColor
        
        stackView.addArrangedSubview(addedToBasketView)
        addedToBasketView.addSubview(addedToBasketLabel)
        
        NSLayoutConstraint.activate([
            addedToBasketLabel.widthAnchor.constraint(equalTo: addedToBasketView.widthAnchor),
            addedToBasketLabel.heightAnchor.constraint(equalTo: addedToBasketView.heightAnchor),
            addedToBasketView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
    }
    
    private func configureAddToBasketButton() {
        addToBasketButton.layer.cornerRadius = 15
        
        let height = addToBasketButton.bounds.height * 0.8
        addToBasketButton.setImage(UIImage.basketIconImage(height: height, color: .white), for: .normal)
        
        addToBasketButton.accessibilityIdentifier = "AddToBasket"
    }
    
    @IBAction private func didPressAddToBasket(_ sender: UIButton) {
        self.stepper.isHidden = true
        self.addToBasketButton.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.addedToBasketView.isHidden = false
        }
        
        if let count = self.stepper.countLabel.text, let countInt = Int(count) {
            self.onPressAddToBasketButton?(countInt)
        }
    }
}

// Count Stepper Delegate
extension AddItemView: CountStepperDelegate {
    
    func configureAddToBasketButton(_ view: UIView, count: Int) {
        addToBasketButton.backgroundColor = count > 0 ? .accentColor : .lightGray
        addToBasketButton.isEnabled = count > 0
    }
}
