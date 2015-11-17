//
//  TMCustomLoginViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/29/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse
import ParseFacebookUtilsV4

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
    @IBAction func loginFace(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (conection, result, error) -> Void in
                        if (error == nil) {
                            if (result["email"] != nil) {
                                user["email"] = result["email"]
                            }
                            if (result["first_name"] != nil) {
                                user["primeiroNome"] = result["first_name"]
                            }
                            if (result["last_name"] != nil) {
                                user["ultimoNome"] = result["last_name"]
                            }
                            if (result["picture"] != nil) {
                                let pic = result["picture"] as! NSDictionary
                                let data = pic["data"] as! NSDictionary
                                let url = data["url"] as! String
                                if let url = NSURL(string: url), let data = NSData(contentsOfURL: url), let downloadedImage = UIImage(data: data) {
                                    print("testando essa porra aqui\(downloadedImage)")
                                    let imageData = UIImagePNGRepresentation(downloadedImage)
                                    
                                    let ias:PFFile = PFFile(name: "perfilFace", data: imageData!)!
                                    user["foto"] = ias
                                }
                            }
                            user.saveInBackground()
                        }
                    })
                    self.performSegueWithIdentifier("loginVai", sender: nil)
                    print("User signed up and logged in through Facebook!")
                } else {
                    self.performSegueWithIdentifier("loginVai", sender: nil)
                    print("User logged in through Facebook!")
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
        
    }
    
}
