//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodAddRect: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var stepper: UIView!
    @IBOutlet var addButton: UIButton!

    private let addedToListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addedToListView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private static let reuseIdentifier = String(describing: FoodAddRect.self)

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
}
