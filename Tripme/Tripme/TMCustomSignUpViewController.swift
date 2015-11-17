//
//  TMCustomSignUpViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 10/29/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMCustomSignUpViewController: UIViewController
{
    @IBOutlet weak var respostaSwitch: UISwitch!
    @IBOutlet weak var criarConta: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmarSenha: UITextField!
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
            user["nome"] = nome
            
            
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
    }
}
