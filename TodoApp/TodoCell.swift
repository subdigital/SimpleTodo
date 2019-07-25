//
//  TodoCell.swift
//  TodoApp
//
//  Created by Ben Scheirman on 7/25/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import UIKit

class TodoCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!

    var strikeThrough: Bool = false {
        didSet {
            if strikeThrough {
                label.attributedText = NSAttributedString(string: label.text ?? "", attributes: [
                    .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                    .foregroundColor: UIColor.lightGray
                    ])
            } else {
                label.text = label.attributedText?.string
            }
        }
    }
}
