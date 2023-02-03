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
    @IBAction func dashboardButtonTapped(_ sender: UIButton) {
        viewModel.trigger.send(AuthRoute.finish)
    }
    
    @IBAction func myProfileButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func crossButtonTapped(_ sender: UIButton) {
        sideMenuController?.hideMenu()
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSectionData.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if MenuSectionData.allCases[section] == .freelancer {
            return viewModel.isFreelanceExpanded ? MenuCellData.allCases.count : 0
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuCell
        let cellItem = MenuCellData.allCases[indexPath.row]
        cell.configure(celltype: cellItem)
        if viewModel.selectedSidemenuType?.title == cellItem.title {
            cell.shadowView.backgroundColor = UIColor.app_primary_gray_0_4
        } else {
            cell.shadowView.backgroundColor = UIColor.app_white
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerLineCell = tableView.dequeueReusableCell(withIdentifier: "MenuLineSectionCell") as! MenuLineSectionCell
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "MenuSectionCell") as! MenuSectionCell
        let sectionData = MenuSectionData.allCases[section]
        switch sectionData {
            
        case .buyer,.employer,.singleLine:
            headerLineCell.configure(desc: sectionData.rawValue)
            return headerLineCell
        case .postWork,.myWorkPost,.postAjob,.myJobPost,.myCandidates,.myCompanyProfile,.myInvoices,.settings:
            headerCell.configure(data: sectionData)
            headerCell.sectionButton.tag = section
            headerCell.sectionButton.addTarget(self, action: #selector(headerClicked), for: .touchUpInside)
            if viewModel.selectedSidemenuType?.title == sectionData.title {
                headerCell.backgroundColorView.backgroundColor = UIColor.app_primary_gray_0_4
            } else {
                headerCell.backgroundColorView.backgroundColor = UIColor.app_white
            }
            return headerCell
            
        case .freelancer:
            headerCell.configure(data: sectionData)
            headerCell.sectionButton.tag = section
            headerCell.sectionButton.addTarget(self, action: #selector(headerClicked), for: .touchUpInside)
            let celltitleString =  MenuCellData.allCases.map({$0.title})
            let isSubmenuSelected = celltitleString.contains(viewModel.selectedSidemenuType?.title ?? "")
            if  isSubmenuSelected  && !viewModel.isFreelanceExpanded{
                headerCell.backgroundColorView.backgroundColor = UIColor.app_primary_gray_0_4
            } else {
                headerCell.backgroundColorView.backgroundColor = UIColor.app_white
            }
            return headerCell
            
        case .logout:
            headerCell.configure(data: sectionData)
            headerCell.backgroundColorView.backgroundColor = UIColor.app_primary_red_0_1
            return headerCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionData = MenuSectionData.allCases[section]
        switch sectionData {
        case .singleLine:  return 20
        default:  return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if MenuSectionData.allCases[indexPath.section] == .freelancer {
            return 45
        }else { return 0  }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return UIView(frame: .zero) }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {  1 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = indexPath.row
        viewModel.selectedSidemenuType = MenuCellData.allCases[rowIndex]
        tableView.reloadData()
    }
   
    @objc func headerClicked(_ sender: UIButton){
        let index = sender.tag
        if MenuSectionData.allCases[index] == .freelancer {
            viewModel.isFreelanceExpanded = !viewModel.isFreelanceExpanded
            tableView.reloadData()
            return
        }
        viewModel.selectedSidemenuType = MenuSectionData.allCases[index]
        tableView.reloadData()
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
