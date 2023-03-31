//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class ItemCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var systemIcon: UIImageView!
    
    static let reuseIdentifier = "ItemCollectionCell"
}
