//
//  TriangleView.swift
//  DevTable
//
//  Created by Алексей Агапов on 15/07/16.
//  Copyright © 2016 ru.testing.project. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

enum TriangleCorner:Int {
  case TopRight
  case TopLeft
  case BottomRight
  case BottomLeft
}

@IBDesignable
class TriangeView : UIView {
  
  var triangleType: TriangleCorner = .TopLeft
  
  // Adapter
  @IBInspectable
  var triangleTypeInt: Int {
    set {
      self.triangleType = TriangleCorner(rawValue: newValue) ?? .TopRight
    }
    get {
      return triangleType.rawValue
    }
  }
  
  @IBInspectable
  var isTopTriangleType: Bool = true {
    didSet {
      setTriangleType()
    }
  }
  
  @IBInspectable
  var isLeftTriangleType: Bool = true {
    didSet {
      setTriangleType()
    }
  }
  
  func setTriangleType() {
    if isLeftTriangleType && isTopTriangleType {
      triangleType = .TopLeft
    } else if isLeftTriangleType && !isTopTriangleType {
      triangleType = .BottomLeft
    } else if !isLeftTriangleType && isTopTriangleType {
      triangleType = .TopRight
    } else if !isLeftTriangleType && !isTopTriangleType {
      triangleType = .BottomRight
    }
  }
  
  @IBInspectable
  var triangleBackgroundColor: UIColor = .brownColor()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.drawRect(frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
    self.drawTriangle(rect, color: triangleBackgroundColor)
  }
  
  private func drawTriangle(rect: CGRect, color:UIColor) {
    guard let ctx : CGContextRef = UIGraphicsGetCurrentContext() else {return}
    
    CGContextBeginPath(ctx)
    switch triangleType {
    case .TopLeft:
      CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, (CGRectGetMinX(rect)), CGRectGetMaxY(rect))
    case .TopRight:
      CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, (CGRectGetMaxX(rect)), CGRectGetMaxY(rect))
    case .BottomLeft:
      CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect))
      CGContextAddLineToPoint(ctx, (CGRectGetMaxX(rect)), CGRectGetMaxY(rect))
    case .BottomRight:
      CGContextMoveToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
      CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect))
      CGContextAddLineToPoint(ctx, (CGRectGetMinX(rect)), CGRectGetMaxY(rect))
    }
    CGContextClosePath(ctx)
    
    CGContextSetFillColorWithColor(ctx, color.CGColor)
    CGContextFillPath(ctx);
  }
}
