//
//  NSAttributedString.swift
//  Qkly
//
//  Created by Arun Sah on 12/11/2021.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    internal convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }

        guard let attributedString = try?  NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString: attributedString)
    }
    
    func heightFor(withWidth width: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.isScrollEnabled = false
        textView.attributedText = self
        
        return textView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
    }
    
    func labelHeightFor(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = self
        label.font = font
        return label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
    }
    func labelWidthFor(withheight height: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = self
        label.font = font

        return label.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height)).width
    }
}

extension NSMutableAttributedString {
    
    /// underlines mutable attributed string.
    /// - Parameters:
    ///   - style: NSUnderlineStyle
    ///   - color: underline color. default "white"
    func underlineString(style: NSUnderlineStyle = .single, color: UIColor = .white) {
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: style.rawValue,
            NSAttributedString.Key.underlineColor: color
        ]
        self.addAttributes(attributes, range: NSRange(location: 0, length: self.string.count))
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    /// adds underline style to dictionary
    /// - Parameter style: NSUnderline style
    mutating func addUnderlineStyle(_ style: NSUnderlineStyle) {
        self.updateValue(style.rawValue, forKey: .underlineStyle)
    }
    
    /// adds underline color property to dictionary
    /// - Parameter color: UIColor
    mutating func addUnderlineColor(_ color: UIColor) {
        self.updateValue(color, forKey: .underlineColor)
    }
    
    /// adds font property to dictionary
    /// - Parameter font: UIFont
    mutating func addFont(_ font: UIFont) {
        self.updateValue(font, forKey: .font)
    }
    
    /// adds text color property to dictionary
    /// - Parameter color: UIColor
    mutating func addTextColor(_ color: UIColor) {
        self.updateValue(color, forKey: .foregroundColor)
    }
    
    /// adds character spacing property to dictionary
    /// - Parameter characterSpacing: Double
    mutating func addCharacterSpacing(_ characterSpacing: Double) {
        self.updateValue(characterSpacing, forKey: .kern)
    }
    
    /// adds paragraph style
    /// - Parameters:
    ///   - alignment: allignment
    ///   - lineBreakMode: line break mode
    mutating func addParagraphStyle(alignment: NSTextAlignment = NSTextAlignment.left, lineBreakMode: NSLineBreakMode = NSLineBreakMode.byWordWrapping) {
        
        guard let oldParaStyle: NSMutableParagraphStyle = self[.paragraphStyle] as? NSMutableParagraphStyle else {
            
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.alignment = alignment
            paraStyle.lineBreakMode = lineBreakMode
            self.updateValue(paraStyle, forKey: .paragraphStyle)
            return
        }
        oldParaStyle.alignment = alignment
        oldParaStyle.lineBreakMode = lineBreakMode
        self.updateValue(oldParaStyle, forKey: .paragraphStyle)
    }
}


public extension NSAttributedString {

    func width(considering height: CGFloat) -> CGFloat {

        let size = self.size(consideringHeight: height)
        return size.width
        
    }
    
    func height(considering width: CGFloat) -> CGFloat {

        let size = self.size(consideringWidth: width)
        return size.height
        
    }
    
    func size(consideringHeight height: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        return self.size(considering: constraintBox)
        
    }
    
    func size(consideringWidth width: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        return self.size(considering: constraintBox)
        
    }
    
    func size(considering size: CGSize) -> CGSize {
        
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
        
    }
}
