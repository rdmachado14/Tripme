//
//  ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/14/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, FBSDKLoginButtonDelegate
{
    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
//        if PFUser.currentUser() == nil
//        {
//            self.logInViewController.fields = PFLogInFields.UsernameAndPassword
//            self.logInViewController.fields = PFLogInFields.LogInButton
//            self.logInViewController.fields = PFLogInFields.SignUpButton
//            self.logInViewController.fields = PFLogInFields.PasswordForgotten
//            self.logInViewController.fields = PFLogInFields.DismissButton
//            
//            let logInLogoTitle = UILabel()
//            logInLogoTitle.text = "Tripme"
//            
//            self.logInViewController.logInView?.logo = logInLogoTitle
//            self.logInViewController.delegate = self
//            let signUpLogoTitle = UILabel()
//            signUpLogoTitle.text = "Tripme"
//            
//            self.signUpViewController.signUpView?.logo = signUpLogoTitle
//            
//            self.signUpViewController.delegate = self
//            
//            self.logInViewController.signUpController = self.signUpViewController
//            
//        }
        
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
    
    // Login do Parse
    
//    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool
//    {
//        if !username.isEmpty || !password.isEmpty
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?)
//    {
//        print("Falha no login!")
//    }
//    
//    // Cadastro do Parse
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?)
//    {
//        print("Falha no cadastro!")
//    }
//    
//    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController)
//    {
//        print("Usuário cancelou o cadastro!")
//    }
    
    // Ações
    
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

    
    
//    @IBAction func btLogin(sender: AnyObject)
//    {
//        self.presentViewController(self.logInViewController, animated: true, completion: nil)
//    }
//    
//    @IBAction func btCustom(sender: AnyObject)
//    {
//        self.performSegueWithIdentifier("custom", sender: self)
//    }
//    
//    
//    @IBAction func btLogout(sender: AnyObject)
//    {
//        PFUser.logOut()
//    }
}
