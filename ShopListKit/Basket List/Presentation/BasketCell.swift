//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    static let reuseIdentifier = String(describing: BasketCell.self)

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        var customBackgroundConfiguration = backgroundConfiguration?.updated(for: state)
        customBackgroundConfiguration?.backgroundColor = UIColor(.darkGreen)

        backgroundConfiguration = customBackgroundConfiguration
    }
}
