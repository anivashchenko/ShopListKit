//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIView {
    func loadNibNamed<T: UIView>() -> T {
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as! T
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }
}
