//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class FoodListCellView: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var systemIconImageView: UIImageView!
    @IBOutlet private var customContentView: UIView!
    
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
