//
//  Handler.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//

import UIKit
import  TTGSnackbar

class Handler: NSObject {
    class func makeToast ( message:String, duration:TimeInterval = 3.0){
        let snackbar = TTGSnackbar.init(message: message, duration: .middle)
        snackbar.messageTextAlign = .center
        snackbar.leftMargin = 10
        snackbar.rightMargin = 10
        snackbar.animationType = .slideFromBottomToTop
        snackbar.backgroundColor = UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 0.7)//UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        snackbar.show()
    }
    class func makeToastwithWhiteBackground ( message:String, duration:TimeInterval = 3.0){
        let snackbar = TTGSnackbar.init(message: message, duration: .middle)
        snackbar.messageTextColor = UIColor.black
        snackbar.messageTextAlign = .center
        snackbar.leftMargin = 10
        snackbar.rightMargin = 10
        snackbar.animationType = .slideFromBottomToTop
        snackbar.backgroundColor = UIColor(red:  255/255, green: 255/255, blue: 255/255, alpha: 0.7)//UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        snackbar.show()
    }
    class func makeToastwithRedBackground ( message:String, duration:TimeInterval = 3.0){
        let snackbar = TTGSnackbar.init(message: message, duration: .middle)
        snackbar.messageTextColor =  UIColor.red
        snackbar.messageTextAlign = .center
        snackbar.leftMargin = 20
        snackbar.rightMargin = 20
        snackbar.animationType = .slideFromBottomToTop
        snackbar.backgroundColor =  UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        snackbar.show()
    }
    

}
