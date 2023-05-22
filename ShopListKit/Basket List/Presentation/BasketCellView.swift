//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class BasketCellView: UITableViewCell {
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var starButton: UIButton!
    
    var viewModel: BasketCellViewModel! {
        didSet {
            itemImageView.image = viewModel.image
            titleLabel.attributedText = viewModel.attributedTitle
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starButton.tintColor = viewModel.starImageColor
            contentView.backgroundColor = viewModel.backgroundColor
        }
    }
    
    @IBAction private func didPressStarButton() {
        viewModel.isFavorite.toggle()
        starButton.tintColor = viewModel.starImageColor
    }
}
