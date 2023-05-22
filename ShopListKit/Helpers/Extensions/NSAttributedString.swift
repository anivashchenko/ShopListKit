//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI

extension NSAttributedString {
    
    static func customAttributedTitle(_ title: String, size: CGFloat, color: UIColor = .white) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: size, weight: .semibold)
        ]
        
        return NSMutableAttributedString(string: title, attributes: attributes)
    }
    
    static func customBasketListHeader(title: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let header = NSAttributedString.customAttributedTitle(title, size: size, color: color)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = size
        header.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: header.length))
        
        return header
    }
    
    static func customFoodListTitle(title: String, count: Int) -> NSMutableAttributedString {
        let attrTitle = customTitleWithCount(title: title, count: count, size: 16, primaryColor: UIColor(.primary), secondaryColor: .darkGray)
        attrTitle.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 16, weight: .regular),
            range: NSRange(location: 0, length: attrTitle.length))
        
        return attrTitle
    }
    
    static func customTitleWithCount(title: String, count: Int, size: CGFloat, primaryColor: UIColor, secondaryColor: UIColor) -> NSMutableAttributedString {
        let attrTitle = customAttributedTitle(title, size: size, color: primaryColor)
        if count != 0 {
            let attrCount = customAttributedTitle(" x\(count)", size: size, color: secondaryColor)
            attrTitle.append(attrCount)
        }
        return attrTitle
    }
}
