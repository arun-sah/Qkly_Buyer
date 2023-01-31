//
//  BioMetricController.swift
//  Qkly
//
//  Created by Arun Sah on 26/07/2022.
//
import Foundation
import UIKit
import LocalAuthentication
import KeychainSwift
import SwiftyAttributes

class BioMetricController: BaseController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bioMetricButton: UIButton!
    @IBOutlet weak var faceBioLoginLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var signUpQuicklyLabel: UILabel!
    var viewModel : BioMetricViewModel!

    /// An authentication context stored at class scope so it's available for use during UI updates.
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
   
    
    @IBAction func bioMetricbuttonAction(_ sender: Any) {
        firstLoginComplete()
        faceAuthinication()
    }
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        firstLoginComplete()
        self.viewModel.userManager?.cacheManager.set(Bool.self, value: false, key: FrameworkCacheKey.isFaceid)
        self.viewModel.trigger.send(AuthRoute.finish)
    }
    
   
}

extension BioMetricController {
     func setUpView() {
         let faceId = AppString.faceId.value.withAttributes([
             .textColor(UIColor.app_primary_purple ?? .purple),
             .font(UIFont.appBoldFont(ofSize: .size_24))
         ])
         let bioMetric = AppString.fingerPrint.value.withAttributes([
             .textColor(UIColor.app_primary_purple ?? .purple),
             .font(UIFont.appBoldFont(ofSize: .size_24))
         ])
         let login = AppString.login.value.withAttributes([
             .textColor(UIColor.app_primary_purple ?? .purple),
             .font(UIFont.appBoldFont(ofSize: .size_24))
         ])
         
             viewModel.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
             viewModel.keychain.synchronizable = true
        
         switch viewModel.context.biometryType {
             case .faceID:
                 image.image = UIImage.faceid_enable
                 let text = faceId + login
                 faceBioLoginLabel.attributedText = text
                 signUpQuicklyLabel.text = AppString.signinQklyFaceid.value
                 bioMetricButton.setTitle(AppString.enableFaceId.value, for: .normal)
             default:
                 image.image = UIImage.fingerprint_enable
                 let text = bioMetric + login
                 faceBioLoginLabel.attributedText = text
                 signUpQuicklyLabel.text = AppString.signinQklyFingerprint.value
                 bioMetricButton.setTitle(AppString.enableFingerprint.value, for: .normal)

             }
          
     }
}


extension BioMetricController {
    
    func firstLoginComplete(){
        self.viewModel.userManager?.cacheManager.set(Bool.self, value: true, key: FrameworkCacheKey.isFirstloginComplete)

    }
    
    @objc func faceAuthinication(){
        viewModel.context = LAContext()
        
        viewModel.context.localizedCancelTitle = AppString.enterUsernamePassword.value
        // First check if we have the needed hardware support.
        var error: NSError?
        if viewModel.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = AppString.loginToYourAccount.value
                viewModel.context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                
                if success {
                    
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        self.viewModel.userManager?.cacheManager.set(Bool.self, value: true, key: FrameworkCacheKey.isFaceid)
                        self.viewModel.trigger.send(AuthRoute.finish)
                    }
                    
                } else {
                    DispatchQueue.main.async { [unowned self] in
                        _ = self.viewModel.userManager?.cacheManager.delete(forKey: FrameworkCacheKey.isFaceid)
                        self.viewModel.trigger.send(AuthRoute.finish)
                    }

                }
            }
        } else {
            DispatchQueue.main.async { [unowned self] in
                _ = self.viewModel.userManager?.cacheManager.delete(forKey: FrameworkCacheKey.isFaceid)
                self.viewModel.trigger.send(AuthRoute.finish)
            }
        }
    }
}
 
