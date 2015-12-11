//
//  TMRecoveryPasswordViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 12/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMRecoveryPasswordViewController: UIViewController
{

    @IBOutlet weak var tfEmail: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func btRecoveryPassword(sender: AnyObject)
    {
        PFUser.requestPasswordResetForEmailInBackground(tfEmail.text!) { (success, error) -> Void in
            
            if self.tfEmail.text == ""
            {
                let alert = UIAlertView(title: "Erro!", message: "Informe seu e-mail.", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
            }
            
            if success
            {
                print("Foi!")
                
                let alert = UIAlertView(title: "Enviado!", message: "Confira seu e-mail.", delegate: self, cancelButtonTitle: "Ok")
                alert.show()
                
            }
            else
            {
                print(error)
            }
        }
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }



}
