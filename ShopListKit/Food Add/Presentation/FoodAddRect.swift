//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodAddRect: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var stepper: CountStepper!
    @IBOutlet private var addToBasketButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private var titleView: UIView!
    
    var onPressAddToBasketButton: ((Int) -> Void)?
    
    private static let reuseIdentifier = String(describing: FoodAddRect.self)
    
    private let addedToBasketView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configureView(name: String, count: Int) {
        titleLabel.attributedText = .customAttributedTitle(name, size: 30, color: .accentColor)
        imageView.image = UIImage(named: name)
        stepper.delegate = self
        stepper.configureStepperView(count: count)
        configureAddToBasketButton(self, count: count)
    }
    
    private func commonInit() {
        let _ = loadNibNamed()
        
        titleView.layer.cornerRadius = 10
        configureAddToBasketButton()
        configureAddedToBasketSubview()
        layer.cornerRadius = 15
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
    }
    
    @IBAction func didPressAddToBasket(_ sender: UIButton) {
        self.stepper.isHidden = true
        self.addToBasketButton.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.addedToBasketView.isHidden = false
        }
        
        if let count = self.stepper.count.text, let countInt = Int(count) {
            self.onPressAddToBasketButton?(countInt)
        }
    }
    
    private func configureAddedToBasketSubview() {
        let addedToBasketLabel = UILabel()
        addedToBasketLabel.translatesAutoresizingMaskIntoConstraints = false
        addedToBasketLabel.attributedText = .customAttributedTitle("Succesfully added to the basket!", size: 18)
        addedToBasketLabel.textAlignment = .center
        
        addedToBasketView.layer.cornerRadius = 10
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
        addToBasketButton.layer.cornerRadius = 10
        
        let height = addToBasketButton.bounds.height * 0.8
        addToBasketButton.setImage(
            .imageFromBezierPath(
                .basketBezierPath(height: height),
                size: .init(width: height, height: height),
                color: UIColor.white.cgColor
            ), for: .normal
        )
        
        addToBasketButton.accessibilityIdentifier = "AddToBasket"
    }
}

// Count Stepper Delegate
extension FoodAddRect: CountStepperDelegate {
    
    func configureAddToBasketButton(_ view: UIView, count: Int) {
        addToBasketButton.backgroundColor = count > 0 ? .accentColor : .lightGray
        addToBasketButton.isEnabled = count > 0
    }
}
