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
    
    func configure(celltype:MenuCellData) {
        iconImage.image = celltype.image
        descLabel.text = celltype.title
        
//        switch celltype {
//        case .findFreelancer:
//            <#code#>
//        case .myFreelancer:
//            <#code#>
//        case .favouriteFreelancer:
//            <#code#>
//        }

    }
    

}
