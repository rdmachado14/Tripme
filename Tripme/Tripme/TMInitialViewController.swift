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

class TMInitialViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        

        
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
            self.performSegueWithIdentifier("showNew", sender: self)
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
        // verificação para saber se o usuário está logado
        if FBSDKAccessToken.currentAccessToken() == nil
        {
            print("Não logado")
        }
        else
        {
            print("Logado")
        }
        
        let loginButton = FBSDKLoginButton() // botão de login do Facebook
        loginButton.readPermissions = ["public_profile", "email", "user_friends"] // permissões do usuário
    }



    
}
