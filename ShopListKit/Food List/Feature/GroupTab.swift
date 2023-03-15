//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class GroupTab: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    static let reuseIdentifier = "GroupTab"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(GroupTab.reuseIdentifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
