//
//  TMCustomSignUpViewController.swift
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

class TMCustomSignUpViewController: UIViewController
{
    @IBOutlet weak var respostaSwitch: UISwitch!
    @IBOutlet weak var criarConta: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmarSenha: UITextField!
    @IBOutlet weak var logarFace: UIButton!
    //var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tfEmail.borderStyle = UITextBorderStyle.RoundedRect
        tfEmail.layer.cornerRadius = 4
        
        tfEmail.borderStyle = UITextBorderStyle.RoundedRect
        tfEmail.layer.cornerRadius = 4
        
        tfUsername.borderStyle = UITextBorderStyle.RoundedRect
        tfUsername.layer.cornerRadius = 4
        
        tfPassword.borderStyle = UITextBorderStyle.RoundedRect
        tfPassword.layer.cornerRadius = 4
        
        tfConfirmarSenha.borderStyle = UITextBorderStyle.RoundedRect
        tfConfirmarSenha.layer.cornerRadius = 4
//        self.actInd.center = self.view.center
//        self.actInd.hidesWhenStopped = true
//        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        //view.addSubview(self.actInd)
        criarConta.layer.cornerRadius = 4
        logarFace.layer.cornerRadius = 4
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // Ações
    
    @IBAction func btSignUp(sender: AnyObject)
    {
        let nome = self.tfUsername.text
        let password = self.tfPassword.text
        let email = self.tfEmail.text
        let confirmarSenha = tfConfirmarSenha.text
        if nome! == "" || password! == ""
        {
            let alert = UIAlertView(title: "Erro!", message: "Por favor, preencha os campos!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if email! == ""
        {
            let alert = UIAlertView(title: "Erro!", message: "Por favor, entre com um e-mail válido!", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else if password != confirmarSenha {
            let alert = UIAlertView(title: "Erro!", message: "As senhas nao são iguais", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else if !respostaSwitch.on {
            let alert = UIAlertView(title: "Erro!", message: "Você precisa aceitar os termos de uso", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            //self.actInd.startAnimating()
            
            let user = PFUser()
            
            user.username = email
            user.password = password
            user.email = email
            user["primeiroNome"] = nome
            
            
            user.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                //self.actInd.stopAnimating()
                
                if error != nil
                {
                    let alert = UIAlertView(title: "Erro!", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                else
                {
                    let alert = UIAlertView(title: "Sucesso", message: "Você agora está cadastrado!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
                
                
            })
            
        }
        


    }
    
    @IBAction func voltar(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loginFacebook(sender: AnyObject) {
        
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
                    self.performSegueWithIdentifier("fbVai", sender: nil)
                    print("User signed up and logged in through Facebook!")
                } else {
                    self.performSegueWithIdentifier("fbVai", sender: nil)
                    print("User logged in through Facebook!")
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
    }
    
    
}
