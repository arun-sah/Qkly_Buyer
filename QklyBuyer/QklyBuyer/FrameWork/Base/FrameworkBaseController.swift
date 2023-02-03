//
//  FrameworkBaseController.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//

import UIKit
import Foundation
import Combine
// MARK: - Making UIviewController confirms to presentable
extension UIViewController: Presentable {
    public var presenting: UIViewController? {
        return self
    }
}

// MARK: - Extract the class name
extension UIViewController {
    public var name: String {
        return String(describing: self)
    }
}
/// The parent of all controller inside app
open class BaseController: UIViewController {
    public var bag = Set<AnyCancellable>()
    
    private lazy var refreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlUsed(_ :)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refreshControlUsed(_ sender: UIRefreshControl) {
        showRefreshControl()
        refreshControlUsed()
    }
    
    func assignRefreshControl(tableView: UITableView) {
        tableView.refreshControl = refreshControl
    }
    
    func assignRefreshControl(collectionView: UICollectionView) {
        collectionView.refreshControl = refreshControl
    }
    
    func showRefreshControl() {
        refreshControl.beginRefreshing()
    }
    
    func hideRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    open func refreshControlUsed() {
        
    }

    /// when view is loaded
    override open func viewDidLoad() {
        super.viewDidLoad()
        /// setup UI
     //   hideHUD()
        setupUI()
        setupNavShadow()
        navigationBarShadow()
        /// observe events
        observeEvents()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUnauthorizedMessage), name: Constant.NotificationName.unauthorized.notificationName, object: nil)
            
        Connection.shared.connectionSate.sink { [weak self] state in
            guard let self = self else { return }
            if state == .notConnected {
                self.showAlert(title: "QKLY", msg: "The internet connection appears to be offline.")
            }
        }.store(in: &bag)
    
    }
    
    @objc func didReceiveUnauthorizedMessage() {

    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name("unauthorized"), object: nil)
    }
    
    func shareSheetPresent(withItems:[Any]){
        let ac = UIActivityViewController(activityItems: withItems, applicationActivities: nil)
        present(ac, animated: true)
    }
    func navigationBarShadow(){
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupNavShadow() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }
    
    
    
    /// setup trigger
    open func setupUI() {
      
    }
    
    /// Observer for events
    open func observeEvents() {}
    
    
}

open class BaseTableController: UITableViewController {
    
    /// when view is loaded
    override open func viewDidLoad() {
        super.viewDidLoad()
//        hideHUD()
        setupNavShadow()
        /// setup UI
        setupUI()
        
        /// observe events
        observeEvents()
    }
    
    func setupNavShadow() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = .white
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }
   
    
    /// show simple alert with ok action
    /// - Parameters:
    ///   - title: title for alert. defaults to app name
    ///   - msg: message for alert
    func showAlert(title: String = "QKLY", msg: String, completion: ((_ action: AlertActionable) -> Void)? = nil) {
      //  let okAction = AlertAction.okay
        
      //  alert(title: title, msg: msg, actions: [okAction], completion: completion)
    }
    
   
    
    /// setup trigger
    open func setupUI() {}
    
    /// Observer for events
    open func observeEvents() {}
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}

extension BaseController {
    /// show simple alert with ok action
    /// - Parameters:
    ///   - title: title for alert. defaults to app name
    ///   - msg: message for alert
    func showAlert(title: String = "QKLY", msg: String, completion: ((_ action: AlertActionable) -> Void)? = nil) {
     //   let okAction = AlertAction.okay
        
      //  alert(title: title, msg: msg, actions: [okAction], completion: completion)
    }
}
