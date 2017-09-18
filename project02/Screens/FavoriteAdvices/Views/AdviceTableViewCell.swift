//
//  AdviceTableViewCell.swift
//  project02
//
//  Created by Andrey Dubov on 11.09.17.
//  Copyright © 2017 Andrey Dubov. All rights reserved.
//

import UIKit

protocol TableViewCellProtocol {
    
    static var nibName : String { get }
    static var cellReuseIdentifier : String { get }
}

class AdviceTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var nibName : String {
        get {
            return "AdviceTableViewCell"
        }
    }

    static var cellReuseIdentifier: String {
        get {
            return "AdviceTableViewCell"
        }
    }

    @IBOutlet weak var adviceTextLabel: UILabel!

}
