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
    @IBOutlet weak var tfButton: UIButton!
    @IBOutlet weak var tfFacebutton: UIButton!
    @IBOutlet weak var navigationTitulo: UINavigationItem!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tfUsername.borderStyle = UITextBorderStyle.RoundedRect
        tfUsername.layer.cornerRadius = 4
        
        tfPassword.borderStyle = UITextBorderStyle.RoundedRect
        tfPassword.layer.cornerRadius = 4
        
        tfButton.layer.cornerRadius = 4
        
        tfFacebutton.layer.cornerRadius = 4
        
        
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
                    self.performSegueWithIdentifier("loginVai", sender: self)
                    //UIApplication.sharedApplication().keyWindow?.rootViewController = TMMenuViewController()
                }
                else
                {
                    let alert = UIAlertView(title: "Erro!", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()

                }
                
                
            })
            
        }
    }
    

    @IBAction func cancelar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
