//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {
    
    @IBOutlet private var itemImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var starButton: UIButton!
    
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
