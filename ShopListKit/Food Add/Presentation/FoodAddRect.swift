//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodAddRect: UIView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stepper: CountStepper!
    @IBOutlet var addToBasketButton: UIButton!
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
    
    private let addedToBasketLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let _ = loadNibNamed()
        
        titleView.layer.cornerRadius = 10
        
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
        
        addedToBasketLabel.attributedText = .customAttributedTitle("Succesfully added to the basket!", size: 18)
        addedToBasketLabel.textAlignment = .center
        addedToBasketView.layer.cornerRadius = 10
        addedToBasketView.backgroundColor = .accentColor
        
        stackView.addArrangedSubview(addedToBasketView)
        addedToBasketView.addSubview(addedToBasketLabel)
        
        NSLayoutConstraint.activate([
            addedToBasketLabel.leadingAnchor.constraint(equalTo: addedToBasketView.leadingAnchor),
            addedToBasketLabel.trailingAnchor.constraint(equalTo: addedToBasketView.trailingAnchor),
            addedToBasketLabel.bottomAnchor.constraint(equalTo: addedToBasketView.bottomAnchor),
            addedToBasketLabel.topAnchor.constraint(equalTo: addedToBasketView.topAnchor),
            addedToBasketView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
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
}
