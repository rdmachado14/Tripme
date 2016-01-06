//
//  TMHeaderCells.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/5/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import Foundation
import UIKit

class TMHeaderCells: UITableViewCell
{
    @IBOutlet weak var lbHeaderCell: UILabel!
    
    var name = "" {
        didSet {
            lbHeaderCell.text = name
        }
    }
    
}
