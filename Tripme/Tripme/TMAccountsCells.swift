//
//  TMAccountsCells.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/5/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import Foundation
import UIKit
import Parse

class TMAccountsCells: UITableViewCell
{
    @IBOutlet weak var imImage: UIImageView!
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var switchCase: UISwitch!
    
    @IBAction func actionSwitch(sender: AnyObject)
    {
        if switchCase.on == false
        {
            print("false")
            
            //PFUser.currentUser()?.deleteInBackground()

        }
        
    }
    
    
}
