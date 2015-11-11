//
//  TMInitialViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/30/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse

class TMInitialViewController: UIViewController
{
    
    
    override func viewDidAppear(animated: Bool) {
        
        let currentUser = PFUser.currentUser()
        if (currentUser != nil) {
            print("esta logado \(currentUser)")
            //self.performSegueWithIdentifier("mainScreen", sender: nil)
        } else {
            print("nao esta logado \(currentUser)")
            
        }
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let currentUser = PFUser.currentUser()
//        if (currentUser != nil) {
//            print("esta logado \(currentUser)")
//
//        } else {
//            print("nao esta logado \(currentUser)")
//            
//        }
        
        // verificação para saber se o usuário está logado
        if FBSDKAccessToken.currentAccessToken() == nil
        {
            print("Não logado")
        }
        else
        {
            print("Logado")
        }
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    // Facebook
    
    @IBAction func btSignUp(sender: AnyObject)
    {
        self.performSegueWithIdentifier("signup", sender: self)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login completo")
            self.performSegueWithIdentifier("vai", sender: self)
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("Usuário saiu")
        
    }
    
    @IBAction func btFB(sender: AnyObject)
    {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    fbLoginManager.logOut()
                }
            }
        })
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        print(segue!.identifier)
        
    }


    
}
