//
//  PaddedTextField.swift
//  Qkly
//
//  Created by Asmin Ghale on 3/11/22.
//

import UIKit

class PaddedTextField: UITextField {
    var padding: CGFloat = 15.0
    override func awakeFromNib() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.bounds.size.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
}

extension UITextView{

    func setPlaceholder(placeHolderText:String? = "Enter some text...") {

        let placeholderLabel = UILabel()
        placeholderLabel.text = placeHolderText
        placeholderLabel.font = UIFont.appFont(ofSize: 12, weight: .regular)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 22222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 9)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(22222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }

}
