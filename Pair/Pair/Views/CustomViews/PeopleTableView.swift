//
//  PeopleTableView.swift
//  Pair
//
//  Created by Natalie Hall on 9/18/21.
//

import UIKit

final class PeopleTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}  // End of Class
