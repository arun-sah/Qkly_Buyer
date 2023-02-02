//
//  SideMenuCell.swift
//  Qkly
//
//  Created by Arun Sah on 21/01/2022.
//


import UIKit
import LocalAuthentication

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    let context = LAContext()
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(iconName:UIImage, desc: String) {
        iconImage.image = iconName.withRenderingMode(.alwaysTemplate)
        descLabel.text = desc
        `switch`.isHidden = true
//        if desc == othersData.bioMetricId.rawValue {
//            `switch`.isHidden = false
//
//            switch context.biometryType {
//            case .none:
//                iconImage.image = UIImage.faceIcon!.withRenderingMode(.alwaysTemplate)
//            case .touchID:
//                iconImage.image = UIImage.touchIcon!.withRenderingMode(.alwaysTemplate)
//            case .faceID:
//                iconImage.image = UIImage.faceIcon!.withRenderingMode(.alwaysTemplate)
//            default : iconImage.image = UIImage.faceIcon!.withRenderingMode(.alwaysTemplate)
//
//            }
//
//        }
    }
    

}
