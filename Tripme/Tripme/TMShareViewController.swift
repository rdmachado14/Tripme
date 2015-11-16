//
//  TMShareViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit
import FBSDKCoreKit

class TMShareViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let content = FBSDKShareLinkContent()
        
        content.contentURL = NSURL(string: "https://www.facebook.com")
        
        let shareButton = FBSDKShareButton()
        
        shareButton.shareContent = content
        shareButton.center = self.view.center
        self.view.addSubview(shareButton)
        

     
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btShareFacebook(sender: AnyObject)
    {
        let shareFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//        shareFacebook.setInitialText("") // texto inicial
//        shareFacebook.addImage() // imagem inicial
        
        self.presentViewController(shareFacebook, animated: true, completion: nil)
        
    }

    @IBAction func btShareTwitter(sender: AnyObject)
    {
        let shareTwitter: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        self.presentViewController(shareTwitter, animated: true, completion: nil)
    }
   

}
