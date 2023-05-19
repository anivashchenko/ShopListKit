//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    static var nib: UINib {
        UINib(nibName: "\(self)", bundle: nil)
    }
}
