//
//  UITableViewCell+Extensions.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
