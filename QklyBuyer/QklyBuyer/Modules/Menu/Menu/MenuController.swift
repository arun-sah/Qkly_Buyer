//
//  SideMenuController.swift
//  Qkly
//
//  Created by Arun Sah on 20/01/2022.
//

import Foundation
import UIKit
import SideMenuSwift
import KeychainSwift

class MenuController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel : MenuViewModel!
    let cellId = "MenuCell"
    let keychain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func setupUI() {
        // Setup tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        sideMenuController?.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        view.layoutIfNeeded()
    }
    
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSectionData.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MenuSectionData.allCases[section] {
        case .Profile:
            return MenuProfileData.allCases.count
        case .jobBoard:
            return MenuJobBoardData.allCases.count
        case .freelance:
           
                return viewModel.freelanceMenuItemsForDisabled.count
        
        case .other:
            return othersData.allCases.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuCell
        
        switch MenuSectionData.allCases[indexPath.section] {
        case .Profile:
            cell.configure(iconName: UIImage.icon_faceid!, desc: MenuProfileData.allCases[indexPath.row].rawValue)
            if viewModel.selectedSidemenuType?.title == MenuProfileData.allCases[indexPath.row].title {
                cell.descLabel.textColor = UIColor.white
                cell.iconImage.tintColor = UIColor.white
                
            } else {
                cell.shadowView.backgroundColor = UIColor.white
                cell.iconImage.tintColor = UIColor.black
            }
        case .jobBoard:
            cell.configure(iconName: UIImage.icon_faceid!, desc: MenuJobBoardData.allCases[indexPath.row].rawValue)
            if viewModel.selectedSidemenuType?.title == MenuJobBoardData.allCases[indexPath.row].title {
                cell.descLabel.textColor = UIColor.white
                cell.iconImage.tintColor = UIColor.white
                
            } else {
                cell.shadowView.backgroundColor = UIColor.white
                cell.iconImage.tintColor = UIColor.black
            }
        case .freelance:
            let items = viewModel.freelanceMenuItemsForDisabled
            let item = items[indexPath.row]
            cell.configure(iconName: UIImage.icon_faceid!, desc: item.title)
            if viewModel.selectedSidemenuType?.title == item.title {
                cell.descLabel.textColor = UIColor.white
                cell.iconImage.tintColor = UIColor.white
                
            } else {
                cell.shadowView.backgroundColor = UIColor.white
                cell.iconImage.tintColor = UIColor.black
            }
        case .other:
            cell.configure(iconName: UIImage.icon_faceid!, desc: othersData.allCases[indexPath.row].rawValue)
            if viewModel.selectedSidemenuType?.title == othersData.allCases[indexPath.row].title {
                cell.descLabel.textColor = UIColor.white
                cell.iconImage.tintColor = UIColor.white
                
            } else {
                cell.shadowView.backgroundColor = UIColor.white
                cell.iconImage.tintColor = UIColor.black
            }
        }
        
        let isBiometrictrue =  self.viewModel.userManager?.cacheManager.get(Bool.self, forKey: FrameworkCacheKey.isFaceid)
        cell.`switch`.isOn = isBiometrictrue ?? false
       
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "MenuSectionCell") as! MenuSectionCell
        headerCell.configure(desc: MenuSectionData.allCases[section].rawValue)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch MenuSectionData.allCases[section] {
        case .Profile:
            return 40
        case .jobBoard:
            return 40
        case .freelance:
            return 40
        case .other:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch MenuSectionData.allCases[indexPath.section] {
        case .Profile:
            return 55
        case .jobBoard:
            return 55
        case .freelance:
            return 55
        case .other:
            if viewModel.userManager!.hasTokken() {
                return 55
            }else{
                return othersData.allCases[indexPath.row].showForGuest ? 55 : 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = indexPath.row
    }
    
   
    
    
    @IBAction func dashboardButtonTapped(_ sender: UIButton) {
        viewModel.trigger.send(AuthRoute.finish)
    }
    
}
extension MenuController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        tableView.reloadData()
        print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}




// Provides access to the side menu controller
public extension UIViewController {
    
    /// Access the nearest ancestor view controller hierarchy that is a side menu controller.
    var sideMenuController: SideMenuController? {
        return findSideMenuController(from: self)
    }
    
    fileprivate func findSideMenuController(from viewController: UIViewController) -> SideMenuController? {
        var sourceViewController: UIViewController? = viewController
        repeat {
            sourceViewController = sourceViewController?.parent
            if let sideMenuController = sourceViewController as? SideMenuController {
                return sideMenuController
            }
        } while (sourceViewController != nil)
        return nil
    }
}
class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}
