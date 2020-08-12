//
//  ViewController.swift
//  RadialLab
//
//  Created by Work on 8/12/20.
//  Copyright © 2020 Work. All rights reserved.
//

import UIKit

@IBDesignable
class CGGradientView : UIView {
    
    @IBInspectable var startColor : UIColor = .red
    @IBInspectable var endColor : UIColor = .green
    
    @IBInspectable var colorLocationStart : CGFloat = 0.0
    @IBInspectable var colorLocationEnd : CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
          return
        }
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [colorLocationStart, colorLocationEnd]
        guard let gradient = CGGradient(
          colorsSpace: colorSpace,
          colors: colors as CFArray,
          locations: colorLocations
        ) else {
          return
        }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(
          gradient,
          start: startPoint,
          end: endPoint,
          options: []
        )
    }
}

@IBDesignable
class CAGradientView : UIView {
    
    @IBInspectable var firstColor : UIColor = .red
    @IBInspectable var secondColor : UIColor = .green
    
    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer(
            start: .center,
            end: .bottomRight,
            colors: [
                firstColor.cgColor,
                secondColor.cgColor
            ],
            type: .axial
        )
        gradient.frame = rect
        self.layer.addSublayer(gradient)
    }
}

import UIKit

extension CAGradientLayer {

    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight

        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }

    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var gradientView : CGGradientView!
    @IBOutlet var gradientViewCa : CAGradientView!

}

