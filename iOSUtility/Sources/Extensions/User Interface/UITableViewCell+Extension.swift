//
//  UITableViewCell+Extension.swift
//  Utility_Tests
//
//  Created by Gandolfi, Pietro on 14.12.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UITableViewCell {

    /// The table view in which this cell is.
    var tableView: UITableView? {
        return next(UITableView.self)
    }

    /// The index path of this cell.
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }

}
