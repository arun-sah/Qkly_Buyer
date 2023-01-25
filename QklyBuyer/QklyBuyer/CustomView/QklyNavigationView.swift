//
//  QklyNavigationView.swift
//  Qkly
//
//  Created by Asmin Ghale on 7/26/22.
//

import UIKit
import Combine
import SideMenuSwift

enum QklyNavigationViewAction {
    case notification
    case profile
    case chat
    case sideMenu
}

@IBDesignable
class QklyNavigationView: UIView {
    
    override init(frame: CGRect) {
        // 1. setup any properties here

        // 2. call super.init(frame:)
        super.init(frame: frame)

        // 3. Setup view from .xib file
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here

        // 2. call super.init(coder:)
        super.init(coder: aDecoder)

        // 3. Setup view from .xib file
        xibSetup()
    }
    
    // Our custom view from the XIB file
    private var view: UIView!

    private func xibSetup() {
        view = loadViewFromNib()

        // use bounds not frame or it'll be offset
        view.frame = bounds

        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {

        let nib = UINib(nibName: "QklyNavigationView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }
    
    @IBOutlet private weak var notificationButton: UIButton!
    @IBOutlet private weak var messageButton: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    
    @IBOutlet private weak var sideMenuButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var contentbgView: UIView!
    
    var viewModel: BaseViewModel?
    var sideMenuController: SideMenuController?
    
    var navigationActionObserver = PassthroughSubject<QklyNavigationViewAction, Never>()
    let usermanager = UserManagerFactory.get()
    @IBInspectable var navBackgroundColor: UIColor? {
        didSet {
            guard bgView != nil else {return}
            bgView.backgroundColor = navBackgroundColor
            contentbgView.backgroundColor = navBackgroundColor
        }
    }
    
    @IBInspectable var title: String? {
        didSet {
            guard bgView != nil else {return}
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = navBackgroundColor
        contentbgView.backgroundColor = navBackgroundColor
        titleLabel.text = title
        
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(messageButtonTapped), for: .touchUpInside)
        sideMenuButton.addTarget(self, action: #selector(sidemenuButtonTapped), for: .touchUpInside)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(profileImageViewTapped)))
    }
    
    func assign(viewmodel: BaseViewModel, sideMenuController: SideMenuController?, imageURL: String) {
        self.viewModel = viewmodel
        self.sideMenuController = sideMenuController
        guard imageURL != "" else {
          //  profileImageView.image = UIImage.emptyUserImage
            return}
      //  profileImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage.emptyUserImage)
    }
    
    @objc private func notificationButtonTapped() {
        if usermanager.hasTokken() {
       // viewModel?.trigger.send(NavigationItemRoute.notificationList)
        } else {
            showAlertForLogin()
        }
    }
    
    @objc private func messageButtonTapped() {
        if usermanager.hasTokken() {
      //  viewModel?.trigger.send(NavigationItemRoute.chat)
        } else {
            showAlertForLogin()
        }
    }
    
    @objc private func profileImageViewTapped() {
        if usermanager.hasTokken() {
         //   viewModel?.trigger.send(NavigationItemRoute.profile)
        } else {
            showAlertForLogin()
        }
       //
    }
    
    @objc private func sidemenuButtonTapped() {
        sideMenuController?.revealMenu()
    }
   private func showAlertForLogin(){
       guard let vc =  BaseController.getTopViewController() as? SideMenuController else {return}
//       vc.showAlertForLogin { action in
//           switch action{
//           case AlertAction.okay:
//                self.usermanager.cacheManager.set(Bool.self, value: false, key: FrameworkCacheKey.isGuestLogin)
//               self.viewModel?.trigger.send(AuthRoute.finish)
//           default:
//               break
//           }
//       }
    }
    
}
