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

    private static let reuseIdentifier = "FoodAddRect"

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed(FoodAddRect.reuseIdentifier, owner: self, options: nil)?.first as? UIView else {
            fatalError("Couldn't load FoodAddRect")
        }
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

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
        
        layer.cornerRadius = 15
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
    }
}
