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
    @IBOutlet weak var ivProfilePicture: UIImageView!
    var profilePictureView = FBSDKProfilePictureView()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
//    func loadPicture() -> FBSDKProfilePictureView
//    {
//        if !profilePictureView
//        {
//            profilePictureView = FBSDKProfilePictureView.init(frame: self)
//        }
//    }

    
}
