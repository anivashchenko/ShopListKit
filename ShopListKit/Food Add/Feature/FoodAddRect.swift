//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodAddRect: UIView {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var stepper: CountStepper!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var titleView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    private let addedToListView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let addedToListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private static let reuseIdentifier = String(describing: FoodAddRect.self)
    var onPressAddButton: (() -> Void)?

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
        
        addButton.layer.cornerRadius = 10
        let height = addButton.bounds.height * 0.8
        addButton.setImage(
            .imageFromBezierPath(
                .basketBezierPath(height: height),
                size: .init(width: height, height: height),
                color: UIColor.white.cgColor
            ), for: .normal
        )
        
        addedToListLabel.attributedText = customAttributedTitle("Succesfully added to the basket!", size: 18, color: .white)
        addedToListLabel.textAlignment = .center
        addedToListView.layer.cornerRadius = 10
        addedToListView.backgroundColor = UIColor.clear
        
        stackView.addArrangedSubview(addedToListView)
        addedToListView.addSubview(addedToListLabel)
        
        NSLayoutConstraint.activate([
            addedToListLabel.leadingAnchor.constraint(equalTo: addedToListView.leadingAnchor),
            addedToListLabel.trailingAnchor.constraint(equalTo: addedToListView.trailingAnchor),
            addedToListLabel.bottomAnchor.constraint(equalTo: addedToListView.bottomAnchor),
            addedToListLabel.topAnchor.constraint(equalTo: addedToListView.topAnchor),
            addedToListView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
        layer.cornerRadius = 15
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
    }
    
    @IBAction func didPressAddToBasket(_ sender: UIButton) {
        self.stepper.isHidden = true
        self.addButton.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.addedToListView.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onPressAddButton?()
        }
    }
}
