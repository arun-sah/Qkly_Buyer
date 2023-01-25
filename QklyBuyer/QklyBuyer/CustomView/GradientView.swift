//
//  GradientView.swift
//  Qkly
//
//  Created by Asmin Ghale on 7/5/22.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
    @IBInspectable var startColor: UIColor = UIColor(red: 4/255, green: 39/255, blue: 105/255, alpha: 1)
    @IBInspectable var endColor: UIColor = UIColor(red: 1/255, green: 91/255, blue: 168/255, alpha: 1)
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    

}
