//
//  TMLikeViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class TMLikeViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let likeButton = FBSDKLikeControl()
        
        likeButton.objectID = "https://www.facebook.com"
        likeButton.center = self.view.center
        self.view.addSubview(likeButton)

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    



}
