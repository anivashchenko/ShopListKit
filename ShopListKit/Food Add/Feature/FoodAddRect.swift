//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodAddRect: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var titleView: UIView!
    @IBOutlet private var stepper: CountStepper!
    @IBOutlet private var addButton: UIButton!
    
    private let addedToListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let addedToListView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
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
        let view = loadNibNamed()

        titleView.layer.cornerRadius = 10
        
        addButton.layer.cornerRadius = 10
        let width = addButton.bounds.width
        addButton.setImage(
            .imageFromBezierPath(
                .basketBezierPath(width: width),
                size: .init(width: width, height: width),
                color: UIColor.white.cgColor
            ), for: .normal
        )
        
        addedToListLabel.attributedText = customAttributedTitle("Succesfully added to the basket!", size: 18, color: .white)
        addedToListLabel.textAlignment = .center
        addedToListView.layer.cornerRadius = 10
        addedToListView.backgroundColor = UIColor(.darkGreen)
        view.addSubview(addedToListView)
        view.addSubview(addedToListLabel)
        
        NSLayoutConstraint.activate([
            addedToListView.leadingAnchor.constraint(equalTo: stepper.leadingAnchor),
            addedToListView.trailingAnchor.constraint(equalTo: addButton.trailingAnchor),
            addedToListView.bottomAnchor.constraint(equalTo: stepper.bottomAnchor),
            addedToListView.heightAnchor.constraint(equalTo: stepper.heightAnchor),
            
            addedToListLabel.leadingAnchor.constraint(equalTo: addedToListView.leadingAnchor),
            addedToListLabel.trailingAnchor.constraint(equalTo: addedToListView.trailingAnchor),
            addedToListLabel.bottomAnchor.constraint(equalTo: addedToListView.bottomAnchor),
            addedToListLabel.heightAnchor.constraint(equalTo: addedToListView.heightAnchor),
        ])
        
        layer.cornerRadius = 15
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
    }
    
    @IBAction func didPressAddToBasket(_ sender: UIButton) {
        stepper.isHidden = true
        addButton.isHidden = true
        addedToListView.isHidden = false
        addedToListLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onPressAddButton?()
        }
    }
}
