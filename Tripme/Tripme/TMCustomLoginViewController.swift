//
//  TMCustomLoginViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/29/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class TMCustomLoginViewController: UIViewController, FBSDKLoginButtonDelegate
{
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
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
    
    // Ações
    
    @IBAction func btLogin(sender: AnyObject)
    {
        let username = self.tfUsername.text
        let password = self.tfPassword.text
        
        if username! == "" || password! == ""
        {
            let alert = UIAlertView(title: "Erro!", message: "Por favor, preencha os campos!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            //self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
             
                //self.actInd.stopAnimating()
                
                if user != nil
                {
                    let alert = UIAlertView(title: "Sucesso!", message: "Você está logado!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                else
                {
                    let alert = UIAlertView(title: "Erro!", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()

                }
                
                
            })
            
        }
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

}
