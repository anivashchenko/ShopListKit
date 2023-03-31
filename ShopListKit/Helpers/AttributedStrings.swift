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
    
    func customCellTitle(title: String, count: Int) -> NSMutableAttributedString {
        let attrTitle = customAttributedTitle(title, size: 16, color: .primary)
        if count != 0 {
            let attrCount = customAttributedTitle(" x\(count)", size: 16, color: .darkGray)
            attrTitle.append(attrCount)
        }
        attrTitle.addAttribute(.font,
                               value: UIFont.systemFont(ofSize: 16, weight: .regular),
                               range: NSRange(location: 0, length: attrTitle.length))
        
        return attrTitle
    }
    
    func customHeader(title: String, size: CGFloat, color: Color) -> NSMutableAttributedString {
        let header = customAttributedTitle(title, size: size, color: color)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = size
        header.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: header.length))
        
        return header
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
