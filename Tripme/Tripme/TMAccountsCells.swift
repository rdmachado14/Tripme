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
        
        let user = PFUser.currentUser()
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
                            //if user!.isNew {
                                FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, location"]).startWithCompletionHandler({ (conection, result, error) -> Void in
                                    if (result["picture"] != nil) {
                                        let pic = result["picture"] as! NSDictionary
                                        let data = pic["data"] as! NSDictionary
                                        let url = data["url"] as! String
                                        if let url = NSURL(string: url), let data = NSData(contentsOfURL: url), let downloadedImage = UIImage(data: data) {
                                            print("testando essa porra aqui\(downloadedImage)")
                                            let imageData = UIImagePNGRepresentation(downloadedImage)
                                            
                                            let ias:PFFile = PFFile(name: "perfilFace", data: imageData!)!
                                            user!["foto"] = ias
                                        }
                                    }
                                })
                            //}
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
