//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    static let reuseIdentifier = String(describing: BasketCell.self)
}
