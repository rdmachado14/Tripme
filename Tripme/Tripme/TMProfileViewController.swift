//
//  TMProfileViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/5/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class TMProfileViewController: UIViewController
{
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbFacebookName: UILabel!
    
    var imagem : UIImage!
    var name: String!
    
    override func viewDidAppear(animated: Bool)
    {
        
        img.image = imagem
        lbFacebookName.text = name
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }

    

}
