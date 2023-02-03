//
//  MenuLineSectionCell.swift
//  QklyBuyer
//
//  Created by arun sah on 03/02/2023.
//


import Foundation

import UIKit

class MenuLineSectionCell: UITableViewCell {
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        descLabel.font = UIFont.appSemiBoldFont(ofSize: .size_14)
    }

    func configure(desc: String) {
        descLabel.font = UIFont.appSemiBoldFont(ofSize: .size_14)
        descLabel.text = desc
    }
    

}
