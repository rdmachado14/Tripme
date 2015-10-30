//
//  TMCustomLoginViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/29/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMCustomLoginViewController: UIViewController
{
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)

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
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
             
                self.actInd.stopAnimating()
                
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

    @IBAction func btSignUp(sender: AnyObject)
    {
        self.performSegueWithIdentifier("signup", sender: self)
    }
}
