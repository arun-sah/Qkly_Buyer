//
//  MenuSectionCell.swift
//  Qkly
//
//  Created by Arun Sah on 16/04/2022.
//

import Foundation

import UIKit

class MenuSectionCell: UITableViewCell {
    
    
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(desc: String) {
        descLabel.text = desc
        
        
    }
    

}
