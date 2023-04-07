//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    static let reuseIdentifier = String(describing: BasketCell.self)
    
    var viewModel: BasketCellViewModel! {
        didSet {
            itemImageView.image = viewModel.image
            titleLabel.attributedText = viewModel.attributedTitle
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starButton.tintColor = viewModel.starImageColor
            contentView.backgroundColor = viewModel.backgroundColor
        }
    }
}
