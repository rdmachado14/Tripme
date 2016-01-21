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
import ParseTwitterUtils
import ParseFacebookUtilsV4

class TMAccountsCells: UITableViewCell
{
    @IBOutlet weak var imImage: UIImageView!
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var switchCase: UISwitch!
    
    let user = PFUser.currentUser()

    @IBAction func actionSwitch(sender: AnyObject)
    {
        if switchCase.on == false
        {
            if  lbAccount.text! == "Twitter"
            {
                PFTwitterUtils.unlinkUserInBackground(user!, block: { (success, error) -> Void in
                    if success
                    {
                        print("Usuário desvinculado com sucesso do Twitter.")
                    }
                    else
                    {
                        print(error)
                    }
                })
            }
            else
            {
                PFFacebookUtils.unlinkUserInBackground(user!, block: { (success, error) -> Void in
                    if success
                    {
                        print("Usuário desvinculado com sucesso do Facebook.")
                    }
                    else
                    {
                        print(error)
                    }
                })
            }
        }
        
        else if switchCase.on == true
        {
            if  lbAccount.text! == "Facebook"
            {
                if !PFFacebookUtils.isLinkedWithUser(user!)
                {
                    PFFacebookUtils.linkUserInBackground(user!, withReadPermissions: nil, block: { (success, error) -> Void in
                        if success
                        {
                            print("Usuário linkado com o Facebook.")
                        }
                        else
                        {
                            print(error)
                        }
                    })
                }
            }
            
            else if lbAccount.text! == "Twitter"
            {
                if !PFTwitterUtils.isLinkedWithUser(user)
                {
                    PFTwitterUtils.linkUser(user!, block: { (success, error) -> Void in
                        if success
                        {
                            print("Usuário linkado com o Twitter.")
                        }
                        else
                        {
                            print(error)
                        }
                    })
                }
            }
        }
    }
}
