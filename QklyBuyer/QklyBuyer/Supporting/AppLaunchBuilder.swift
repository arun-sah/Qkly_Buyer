//
//  AppLaunchBuilder.swift
//  QklyBuyer
//
//  Created by arun sah on 19/01/2023.
//


import UIKit
import IQKeyboardManagerSwift
import Combine
import SideMenuSwift

final class AppLaunchBuilder {
    
    /// The launch options when app is launched
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    /// The key application or current application
    var application: UIApplication = UIApplication.shared
    
    /// The framework of the application
    var framework: Framework!
    
    /// The shared instance
    static let `default` = AppLaunchBuilder()
    private init() {}
    
    
    
    /// The window of the app
    private var window: UIWindow?
    
    /// The main coordinator for the app
    private lazy var appCoordinator: Coordinator = { self.getAppCoordinator() }()
    
    /// the bag
    private var bag = Set<AnyCancellable>()
    
    /// Method to generate new app coordinator when the app launches
    /// - Parameter window: the window for the app
    @discardableResult
    func generateApplicationState(with window: UIWindow?) -> Bool {
        
        /// keep the refrence to window
        self.window = window
        
        //setup IQKeyboardManager
        setupIQKeyboardManager()
        
        //setup navigationbar appearence
        setupNavigationBarAppearence()
        
        /// initialize the framework
        framework = self.configureFramework()
        
        // run the coordinator
        setAppCordinator()
        configureSideMenu()
        
        //let the app starts
        return true
    }
    
    func setAppCordinator(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
                self.appCoordinator.start(with: nil)
        }
       
    }
    
}

extension AppLaunchBuilder {
    /// Method to setup the framework with client configuration
    private func configureFramework() -> Framework {
        
        /// Prepare the configuration
        let clientConfig = ClientConfig { [unowned self] (config) in
            config.application = self.application
            config.environment = self.getEnvironement()
            config.launchOptions = self.launchOptions
        }
        
        /// initialize the framework
        let framework = Framework(config: clientConfig)
        
        /// prepare the framework
        framework.initialize()
        
        // return
        return framework
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 300
        SideMenuController.preferences.basic.position = .above
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        
    }
    
    /// Method to initialize and create the app coordinator for the app
    ///
    /// - Returns: the appcoordinator
    private func getAppCoordinator() -> Coordinator {
        
        //chekc if the window was properly initialized
        guard let window = window else {
            fatalError("Window not initailized properly")
        }
        
        //set the root of window and make window key and visible
        let rootNavigationController = UINavigationController()
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        //return the coordinator
        let userManager = UserManagerFactory.get()
        return AppCoordinator(route: Route(rootController: rootNavigationController), userManager:userManager)
    }
    
    /// Method to get environement based on scheme
    private func getEnvironement() -> Environment {
        return AppEnviroment()
     
    }
    
    /// Method to setup navigation bar appearence in whole app
    private func setupNavigationBarAppearence() {
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
        var titleTextAttributes: [NSAttributedString.Key: Any] = [:]
        titleTextAttributes.addCharacterSpacing(0.85)
        
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    /// setting up IQKeyboard manager
    private func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = UIColor.app_primary_purple
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30.0
    }
}
