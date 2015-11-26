//
//  TMTripProjectViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/24/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class TMTripProjectViewController: UIViewController
{

    
    @IBOutlet weak var ivTripImage: UIImageView!
    @IBOutlet weak var lbTripName: UILabel!
    @IBOutlet weak var ivProfilePicture: UIImageView!
    @IBOutlet weak var lbTripHost: UILabel!
    @IBOutlet weak var lbCollected: UILabel!
    @IBOutlet weak var lbTripTotal: UILabel!
    @IBOutlet weak var lbTripHostLastName: UILabel!
    @IBOutlet weak var pvTripProgress: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = ivTripImage {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }



    // Referência para os outlets de arrecadação e o total
    var collectedNumber = Float()
    var tripTotalNumber = Float()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lbTripName.text = "Naboo"
        
        lbCollected.text = "1200"
        lbTripTotal.text = "2000"
        
        progressViewAction()
        
        // scroll
        scrollView.contentSize.height = 10000
        
        ivTripImage!.image = UIImage(named: imageName)
        
        
    }
    

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        let currentUser = PFUser.currentUser()
        print("esta logado: \(currentUser)")
        print("nome: \(currentUser!["primeiroNome"])")
        
        if currentUser!["primeiroNome"] != nil
        {
            lbTripHost.text = (currentUser!["primeiroNome"] as! String)
        }
        
        if currentUser!["ultimoNome"] != nil
        {
            lbTripHostLastName.text = (currentUser!["ultimoNome"] as! String)
        }
        
        if currentUser!["foto"] != nil
        {
            let imageFile  = currentUser!["foto"]
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    self.ivProfilePicture.image = UIImage(data: data!)
                }
            }
        }
        
    }
    
    func progressViewAction()
    {
        self.collectedNumber = NSString(string: lbCollected.text!).floatValue
        self.tripTotalNumber = NSString(string: lbTripTotal.text!).floatValue
        
        dispatch_async(dispatch_get_main_queue())
            {
                self.pvTripProgress.setProgress(self.collectedNumber/self.tripTotalNumber, animated: true)
        }
        
    }
    
    
    
    

}