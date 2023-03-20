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

extension UIBezierPath {
    
    static func basketBezierPath(width: Double) -> UIBezierPath {
        let path = UIBezierPath()
        let height = width
        let spacing = width * 0.075
        let doubleSpacing = spacing * 2
        let padding = width * 0.25
        let verticalPadding = height * 0.1
        let topOfCover = height / 3
        let bottomOfCover = topOfCover + height * 0.15
        let topOfBasket = bottomOfCover + spacing / 1.5
        let bottomOfBasket = height - verticalPadding
                
        path.append(drawHand(distance: padding, spacing: spacing, top: verticalPadding, bottom: topOfCover))
        path.append(drawHand(distance: width - padding, spacing: -spacing, top: verticalPadding, bottom: topOfCover))
        path.append(drawCover(width: width, spacing: spacing, top: topOfCover, bottom: bottomOfCover))
        path.append(drawBasket(width: width, spacing: doubleSpacing, top: topOfBasket, bottom: bottomOfBasket))
        path.append(getLinePath(xPoint: width * 0.32, width: width))
        path.append(getLinePath(xPoint: width * 0.44, width: width))
        path.append(getLinePath(xPoint: width * 0.56, width: width))
        path.append(getLinePath(xPoint: width * 0.68, width: width))
                        
        return path
    }
    
    private static func drawHand(distance: Double, spacing: Double, top: Double, bottom: Double) -> UIBezierPath {
        let path = UIBezierPath()
        let widthLine = spacing
        let topFromEdgeX = distance + widthLine
        let topFromCenterX = distance + widthLine * 1.75
        let bottomFromEdgeX = distance - widthLine
        let topFromEdgeY = top * 1.25
        let topFromCenterY = topFromEdgeY * 1.25
        
        path.move(to: CGPoint(x: topFromEdgeX, y: topFromEdgeY))
        path.addQuadCurve(
            to: CGPoint(x: topFromCenterX, y: topFromCenterY),
            controlPoint: CGPoint(x: topFromCenterX, y: top))
        path.addLine(to: CGPoint(x: bottomFromEdgeX + widthLine, y: bottom))
        path.addLine(to: CGPoint(x: bottomFromEdgeX, y: bottom))
        path.close()
        
        return path
    }
    
    private static func drawCover(width: Double, spacing: Double, top: Double, bottom: Double) -> UIBezierPath {
        let path = UIBezierPath()
        let leftSpacingX = spacing
        let leftCurveSpacingX = spacing * 2
        let rightSpacingX = width - spacing
        let rightCurveSpacingX = width - spacing * 2
        let topCurveY = top * 1.2
        let bottomCurveY = bottom / 1.2
        
        path.move(to: CGPoint(x: leftSpacingX, y: topCurveY))
        path.addQuadCurve(
            to: CGPoint(x: leftCurveSpacingX, y: top),
            controlPoint: CGPoint(x: leftSpacingX, y: top))
        path.addLine(to: CGPoint(x: rightCurveSpacingX, y: top))
        path.addQuadCurve(
            to: CGPoint(x: rightSpacingX, y: topCurveY),
            controlPoint: CGPoint(x: rightSpacingX, y: top))
        path.addLine(to: CGPoint(x: rightSpacingX, y: bottomCurveY))
        path.addQuadCurve(
            to: CGPoint(x: rightCurveSpacingX, y: bottom),
            controlPoint: CGPoint(x: rightSpacingX, y: bottom))
        path.addLine(to: CGPoint(x: leftCurveSpacingX, y: bottom))
        path.addQuadCurve(
            to: CGPoint(x: leftSpacingX, y: bottomCurveY),
            controlPoint: CGPoint(x: leftSpacingX, y: bottom))
        path.close()
        
        return path
    }
    
    private static func drawBasket(width: Double, spacing: Double, top: Double, bottom: Double) -> UIBezierPath {
        let path = UIBezierPath()
        let topLeft = spacing
        let topRight = width - spacing
        let bottomLeftX = spacing * 1.25
        let bottomRightX = width - spacing * 1.25
        let bottomLeftCurveX = spacing * 1.4
        let bottomRightCurveX = width - spacing * 1.4
        let bottomLeftEndCurveX = spacing * 1.75
        let bottomRightEndCurveX = width - spacing * 1.75
        let bottomEndCurveY = bottom * 0.9

        path.move(to: CGPoint(x: bottomLeftX, y: bottomEndCurveY))
        path.addQuadCurve(
            to: CGPoint(x: bottomLeftEndCurveX, y: bottom),
            controlPoint: CGPoint(x: bottomLeftCurveX, y: bottom))
        path.addLine(to: CGPoint(x: bottomRightEndCurveX, y: bottom))
        path.addQuadCurve(
            to: CGPoint(x: bottomRightX, y: bottomEndCurveY),
            controlPoint: CGPoint(x: bottomRightCurveX, y: bottom))
        path.addLine(to: CGPoint(x: topRight, y: top))
        path.addLine(to: CGPoint(x: topLeft, y: top))
        path.close()
        
        return path
    }
    
    private static func getLinePath(xPoint: Double, width: Double) -> UIBezierPath {
        let widthOfLine = width * 0.05
        let heightOfLine = width * 0.275
        let originX = xPoint - widthOfLine/2
        let originY = width * 0.575
        let cornerRadius = 20.0
        
        let pathLine = UIBezierPath(
            roundedRect: CGRect(
                origin: CGPoint(x: originX, y: originY),
                size: CGSize(width: widthOfLine, height: heightOfLine)),
            cornerRadius: cornerRadius)
        
        return pathLine
    }
}
