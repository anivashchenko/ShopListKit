//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodListCellView: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var systemIconImageView: UIImageView!
    @IBOutlet var customContentView: UIView!
    
    var viewModel: FoodListCellViewModel! {
        didSet {
            imageView.image = viewModel.image
            titleLabel.attributedText = viewModel.attributedTitle
            systemIconImageView.image = viewModel.systemIcon
            customContentView.backgroundColor = viewModel.backgroundColor
            customContentView.layer.cornerRadius = 15
        }
    }
}
