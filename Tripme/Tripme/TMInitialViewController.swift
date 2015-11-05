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
    
    @IBOutlet weak var img: UIImageView!
      override func viewDidAppear(animated: Bool) {

//        verificação para saber se o usuário está logado
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
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email","user_location"], handler: { (result, error) -> Void in // pegando tokens do facebook
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
    
    func getFBUserData()
    {
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, location"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                  
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
                        print(downloadedImage.size)
                        print(data.length)
                        print(downloadedImage)
        
                        let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("profile") as! TMProfileViewController
        
                        print("Profile")
                        print(profile)
                        print("Profile.img")

        
     
                        profile.imagem = downloadedImage // carregando imagem do perfil
                        profile.name = name // carregando o nome do perfil
                        profile.location = nameLocation // carregando a localização do perfil

        
                        UIApplication.sharedApplication().keyWindow?.rootViewController = profile
                    }
                    
                    
                }
            })
        }
    }
}
