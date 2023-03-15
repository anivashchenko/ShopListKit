//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

extension UIViewController {

    func customAttributedTitle(_ title: String, size: CGFloat, color: Color) -> NSMutableAttributedString {
        return view.customAttributedTitle(title, size: size, color: color)
    }

    func customTitleWithCount(title: String, count: Int, size: CGFloat, primaryColor: Color, secondaryColor: Color) -> NSMutableAttributedString {

        let attrTitle = customAttributedTitle(title, size: size, color: primaryColor)
        let attrCount = customAttributedTitle(" x\(count)", size: size, color: secondaryColor)
        attrTitle.append(attrCount)
        
        return attrTitle
    }
}

extension UIView {
    
    func customAttributedTitle(_ title: String, size: CGFloat, color: Color) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(color),
            .font: UIFont.systemFont(ofSize: size, weight: .semibold)
        ]
        
        let string = NSMutableAttributedString(string: title, attributes: attributes)
        
        return string
    }
}
