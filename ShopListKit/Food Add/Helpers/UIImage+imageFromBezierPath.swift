//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func imageFromBezierPath(_ bezierPath: UIBezierPath, size: CGSize, color: CGColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { context in
            context.cgContext.setFillColor(color)
            context.cgContext.setStrokeColor(color)
            context.cgContext.addPath(bezierPath.cgPath)
            context.cgContext.drawPath(using: .eoFill)
        }
        
        return image
    }
}
