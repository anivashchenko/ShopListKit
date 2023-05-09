//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI

extension NSAttributedString {
    
    static func customTitleWithCount(title: String, count: Int, size: CGFloat, primaryColor: UIColor, secondaryColor: UIColor) -> NSMutableAttributedString {
        let attrTitle = customAttributedTitle(title, size: size, color: primaryColor)
        let attrCount = customAttributedTitle(" x\(count)", size: size, color: secondaryColor)
        attrTitle.append(attrCount)
        
        return attrTitle
    }
    
    static func customAttributedTitle(_ title: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: size, weight: .semibold)
        ]
        
        return NSMutableAttributedString(string: title, attributes: attributes)
    }
}

