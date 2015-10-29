//
//  TMFacebookLoginViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/28/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class TMFacebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
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
        loginButton.center = self.view.center
        
        loginButton.delegate = self
        
        self.view.addSubview(loginButton) // adicionando o botão a view
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
    
    
}
