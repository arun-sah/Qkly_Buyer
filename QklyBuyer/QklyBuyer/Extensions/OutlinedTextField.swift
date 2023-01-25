//
//  OutlinedTextField.swift
//  Qkly
//
//  Created by Arun Sah on 17/11/2021.
//

import Foundation
import MaterialComponents
import MaterialComponents.MaterialTextFields
import UIKit
class OutlinedTextField: UITextField{
    func setUpTextField(textfield:MDCOutlinedTextField, placeholder:String){
        textfield.label.text = placeholder
        textfield.setOutlineColor(UIColor.appColor!, for: .editing)
        textfield.sizeToFit()
    }
    func setUpTextFieldDropDown(textfield:MDCOutlinedTextField, placeholder:String){
        textfield.label.text = placeholder
      //  let image = UIImage.arrowDown
     //   let imageview = UIImageView(image: image )
      //  imageview.tintColor = UIColor.black
       // textfield.rightView = imageview
        textfield.rightViewMode = .always
        textfield.setOutlineColor(UIColor.appColor!, for: .editing)
        textfield.sizeToFit()
    }
    func setUpTextFieldForPassword(textfield:MDCOutlinedTextField, placeholder:String){
        textfield.label.text = placeholder
        textfield.isSecureTextEntry = true
        textfield.setOutlineColor(UIColor.appColor!, for: .editing)
        textfield.sizeToFit()
    }
    
}
