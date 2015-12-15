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
import ParseFacebookUtilsV4

class TMInitialViewController: UIViewController
{
    
    @IBOutlet weak var btCriarConta: UIButton!
    @IBOutlet weak var btLogarFace: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    @IBOutlet weak var btEntrar: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        //PFUser.logOut()
        let currentUser = PFUser.currentUser()
        if (currentUser != nil) {
            print("esta logado \(currentUser)")
            self.performSegueWithIdentifier("mainScreen", sender: nil)
        } else {
            print("nao esta logado \(currentUser)")
            
        }
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        
        tfEmail.borderStyle = UITextBorderStyle.RoundedRect
        tfEmail.layer.cornerRadius = 4
        
        tfSenha.borderStyle = UITextBorderStyle.RoundedRect
        tfSenha.layer.cornerRadius = 4
        
        btCriarConta.layer.cornerRadius = 4
        btCriarConta.backgroundColor = UIColor.blackColor().azulEscuro
        
        btLogarFace.layer.cornerRadius = 4
        
        btEntrar.layer.cornerRadius = 4
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
        
        

        
        
    }
    
    
    @IBAction func Entrar(sender: AnyObject) {
        
        let username = self.tfEmail.text
        let password = self.tfEmail.text
        
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
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_location"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, location"]).startWithCompletionHandler({ (conection, result, error) -> Void in
                        if (error == nil) {
                            print(result)
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
                            if (result["location"] != nil) {
                                let location = result["location"] as! NSDictionary
                                
                                let nameLocation = location["name"] as! String
                                print(nameLocation)
                                user["localidade"] = nameLocation
                            }
                            user.saveInBackground()
                        }
                    })
                    self.performSegueWithIdentifier("mainScreen", sender: nil)
                    print("User signed up and logged in through Facebook!")
                } else {
                    self.performSegueWithIdentifier("mainScreen", sender: nil)
                    print("User logged in through Facebook!")
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        fbLoginManager .logInWithReadPermissions(["email","user_location"], handler: { (result, error) -> Void in // pegando tokens do facebook
//            if (error == nil){
//                let fbloginresult : FBSDKLoginManagerLoginResult = result
//                if(fbloginresult.grantedPermissions.contains("email"))
//                {
//                    self.getFBUserData()
//                    fbLoginManager.logOut()
//                }
//             }
//        })
        
    }
    
    func getFBUserData()
    {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, location"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                  print("entrou awui 2")
                    print(result)
                    
                    // constantes para pegar as informações do usuário direto do Facebook
                    let pic = result["picture"] as! NSDictionary
                    let data = pic["data"] as! NSDictionary
                    let url = data["url"] as! String
                    let name = result["name"] as! String
                    let location = result["location"] as! NSDictionary
                    let nameLocation = location["name"] as! String
                
                    if let url = NSURL(string: url), let data = NSData(contentsOfURL: url), let downloadedImage = UIImage(data: data)
                    {
                        print("entrou awui")
                        print(downloadedImage.size)
                        print(data.length)
                        print("testando essa porra aqui\(downloadedImage)")
                        
                        
                        let currentUser = PFUser.currentUser()
                        let imageData = UIImagePNGRepresentation(downloadedImage)
                        print("testando o imageData: \(imageData)")
                        let ias:PFFile = PFFile(name: "perfilFace", data: imageData!)!
                        currentUser!["foto"] = ias
                        currentUser!.saveInBackground()
        
//                        let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("profile") as! TMProfileViewController
//        
//                        print("Profile")
//                        print(profile)
//                        print("Profile.img")
//
//                        
//     
//                        profile.imagem = downloadedImage // carregando imagem do perfil
//                        profile.name = name // carregando o nome do perfil
//                        profile.location = nameLocation // carregando a localização do perfil
//
//        
//                        UIApplication.sharedApplication().keyWindow?.rootViewController = profile
                    }
                    
                    
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        print(segue!.identifier)
        
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }



    
}
