//
//  ResizingTableView.swift
//  Qkly
//
//  Created by Asmin Ghale on 3/11/22.
//

import UIKit

final class ResizingTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
