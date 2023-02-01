//
//  UIImage.swift
//  QklyBuyer
//
//  Created by arun sah on 20/01/2023.
//

import UIKit

extension UIImage {
    
    /// Helper method to verify and get the image with given name
    /// - Parameter imageName: the name of image from asset
    /// - Returns: the image from given name
    private static func named(_ imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            assertionFailure("The image associated with name \(imageName) was not found. Please check you have spelled it correctly.")
            return UIImage()
        }
        return image
    }
    
    
    // MARK:- ICONs
    static var icon_Add_job:                 UIImage? { return UIImage.named("Add_job") }
    static var icon_add:                     UIImage? { return UIImage.named("add") }
    static var icon_applied:                 UIImage? { return UIImage.named("applied") }
    static var icon_arrow_left:              UIImage? { return UIImage.named("arrow-left") }
    static var icon_arrow_right :            UIImage? { return UIImage.named("arrow-right") }
    static var icon_calendar :               UIImage? { return UIImage.named("calendar") }
    static var icon_camera :                 UIImage? { return UIImage.named("camera") }
    static var icon_candidate :              UIImage? { return UIImage.named("candidate") }
    static var icon_candidates :             UIImage? { return UIImage.named("candidates") }
    static var icon_Chat :                   UIImage? { return UIImage.named("Chat") }
    static var icon_checked :                UIImage? { return UIImage.named("checked") }
    static var icon_checkmark_circle_2 :     UIImage? { return UIImage.named("checkmark-circle-2") }
    static var icon_close :                  UIImage? { return UIImage.named("close") }
    static var icon_Company :                UIImage? { return UIImage.named("Company") }
    static var icon_copy :                   UIImage? { return UIImage.named("copy") }
    static var icon_cross :                  UIImage? { return UIImage.named("cross") }
    static var icon_Deadline :               UIImage? { return UIImage.named("Deadline") }
    static var icon_download :               UIImage? { return UIImage.named("download") }
    static var icon_email :                  UIImage? { return UIImage.named("email") }
    static var icon_eye :                    UIImage? { return UIImage.named("eye") }
    static var icon_faceid :                 UIImage? { return UIImage.named("faceid") }
    static var icon_fav :                    UIImage? { return UIImage.named("fav") }
    static var icon_fingerprint :            UIImage? { return UIImage.named("fingerprint") }
    static var icon_freelance_hour :         UIImage? { return UIImage.named("freelance_hour") }
    static var icon_freelancer :             UIImage? { return UIImage.named("freelancer") }
    static var icon_funnel :                 UIImage? { return UIImage.named("funnel") }
    static var icon_Hamburger :              UIImage? { return UIImage.named("Hamburger") }
    static var icon_Invoice :                UIImage? { return UIImage.named("Invoice") }
    static var icon_Logout :                 UIImage? { return UIImage.named("Logout") }
    static var icon_message_square :         UIImage? { return UIImage.named("message-square") }
    static var icon_navigation_2 :           UIImage? { return UIImage.named("navigation_2") }
    static var icon_Notification :           UIImage? { return UIImage.named("Notification") }
    static var icon_pending :                UIImage? { return UIImage.named("pending") }
    static var icon_people_fill :            UIImage? { return UIImage.named("people-fill") }
    static var icon_phone :                  UIImage? { return UIImage.named("phone") }
    static var icon_post_work_1 :            UIImage? { return UIImage.named("post_work_1") }
    static var icon_post_work :              UIImage? { return UIImage.named("post_work") }
    static var icon_Profile_accepted :       UIImage? { return UIImage.named("Profile_accepted") }
    static var icon_Projects :               UIImage? { return UIImage.named("Projects") }
    static var icon_Rehire :                 UIImage? { return UIImage.named("Rehire") }
    static var icon_Resume :                 UIImage? { return UIImage.named("Resume") }
    static var icon_search :                 UIImage? { return UIImage.named("search") }
    static var icon_Setting :                UIImage? { return UIImage.named("Setting") }
    static var icon_share :                  UIImage? { return UIImage.named("share") }
    static var icon_Sort :                   UIImage? { return UIImage.named("Sort") }
    static var icon_Time_logged :            UIImage? { return UIImage.named("Time_logged") }
    static var icon_twitter :                UIImage? { return UIImage.named("twitter") }
    static var icon_user :                   UIImage? { return UIImage.named("user") }
    static var icon_watch :                  UIImage? { return UIImage.named("watch") }
    static var icon_Web :                    UIImage? { return UIImage.named("Web") }
    static var icon_zip_code :               UIImage? { return UIImage.named("zip_code") }
   

    // MARK: Onboarding
    static var onboarding_background_map :   UIImage? { return UIImage.named("onboarding_background_map") }
    static var onboarding_1 :                UIImage? { return UIImage.named("onboarding_1") }
    static var onboarding_2 :                UIImage? { return UIImage.named("onboarding_2") }
    static var onboarding_3 :                UIImage? { return UIImage.named("onboarding_3") }
    static var onboarding_4 :                UIImage? { return UIImage.named("onboarding_4") }
    
    //MARK:- biometric login
    static var fingerprint_enable :           UIImage? { return UIImage.named("fingerprint_enable") }
    static var faceid_enable :                UIImage? { return UIImage.named("faceid_enable") }

    // MARK:- extra
    static var congratulation :                UIImage? { return UIImage.named("congratulation") }
    static var forgotPassword :                UIImage? { return UIImage.named("forgotPassword") }
    static var emailSent :                     UIImage? { return UIImage.named("emailSent") }
    static var facebook_email_background :     UIImage? { return UIImage.named("facebook_email_background") }

    
    
    
  
    
}
