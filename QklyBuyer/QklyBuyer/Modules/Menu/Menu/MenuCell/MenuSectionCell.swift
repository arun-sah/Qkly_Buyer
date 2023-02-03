//
//  MenuSectionCell.swift
//  Qkly
//
//  Created by Arun Sah on 16/04/2022.
//

import Foundation

import UIKit

class MenuSectionCell: UITableViewCell {
    
    
    @IBOutlet weak var leadingImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var ddownArrowImage: UIImageView!
    
    
    @IBOutlet weak var sectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        descLabel.font = UIFont.appMediumFont(ofSize: .size_16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(data: MenuSectionData) {
        descLabel.font = UIFont.appMediumFont(ofSize: .size_16)
        descLabel.textColor = UIColor.app_primary_black ?? .black
        descLabel.text = data.title.trim
        leadingImageView.image = data.image
        
        if data == .freelancer {
            ddownArrowImage.image = UIImage.icon_drop_down?.withTintColor(UIColor.app_primary_black_0_6 ?? .black)
            ddownArrowImage.isHidden = false
        } else {
            ddownArrowImage.isHidden = true
        }
    }
    

}
