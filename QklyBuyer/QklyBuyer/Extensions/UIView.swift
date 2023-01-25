//
//  UIView.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//

import Foundation
import UIKit

extension UIView {
    
    class func get<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// The name of the view
    public static var identifier: String {
        return String(describing: self)
    }
    
    /// Method to make Uiviews corners round
    /// - Parameters:
    ///   - edges: the edges to make round
    ///   - radius: the radius by which the roundness is added
    public func rounded(edges: UIRectCorner, radius: CGFloat) {
        self.layer.cornerRadius = radius
        var cornerMask = CACornerMask()
        if edges.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if edges.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if edges.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if edges.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        self.layer.maskedCorners = cornerMask
    }
    
    func border(width: CGFloat = 1.0, color: UIColor = UIColor.systemGray5) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func round(cornerRadius: CGFloat? = nil) {
        self.cornerRadius = cornerRadius ?? frame.height / 2
    }
    func qklyButtonround(cornerRadius: CGFloat? = nil) {
        self.cornerRadius = 4
    }
    
    func popIn(fromScale: CGFloat = 0.5,
                                  duration: TimeInterval = 2,
                                  delay: TimeInterval = 0,
                                  completion: ((Bool) -> Void)? = nil) -> UIView {
      isHidden = false
      alpha = 0
      transform = CGAffineTransform(scaleX: fromScale, y: fromScale)
      UIView.animate(
        withDuration: duration, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
        options: [.curveEaseOut, .repeat, .autoreverse], animations: {
          self.transform = .identity
          self.alpha = 1
        }, completion: completion)
      return self
    }
    
}


@IBDesignable extension UIView {
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable var cornerRadius: CGFloat {
           get { return layer.cornerRadius }
           set {
                 layer.cornerRadius = newValue

                 // If masksToBounds is true, subviews will be
                 // clipped to the rounded corners.
                 layer.masksToBounds = (newValue > 0)
           }
       }
   
        
        @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable var borderColor: UIColor? {
            get {
                return UIColor(cgColor: layer.borderColor!)
            }
            set {
                layer.borderColor = newValue?.cgColor
            }
        }
}

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension UIView {
    func addDashedBorder(lineWith:CGFloat = 2) {
        let color = UIColor.init(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWith
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [3,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addTapGesture(target: Any?, selector: Selector?) -> UITapGestureRecognizer{
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(tapGesture)
        return tapGesture
    }
}


extension UIDevice {
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.keyWindow
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}
