//
//  TMPagamento2TableViewCell.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/25/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMPagamento2TableViewCell: UITableViewCell
{
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var textInfo: UITextField!
    var flag: Int!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
      
    }

//    @IBAction func acaoText(sender: AnyObject)
//    {
//        
//        if flag == 0
//        {
//            print("0")
//        }
//        else if flag == 1
//        {
//            print("1")
//        }
//        else if flag == 2
//        {
//            print("2")
//        }
//        else
//        {
//            print("3")
//        }
//
//    }
}
