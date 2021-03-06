//
//  TMPagamento2ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/25/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMPagamento2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    let info = ["Nome", "Número do cartão", "C.E.P.", "Validade", "Código de segurança"]
    let infoPlaceholder = ["Nome", "Número do cartão", "C.E.P.", "02/2018", "123"]
    var loadNomeViagem: String!
    var loadDataViagem: String!
    var loadValorViagem: String!
    var vetor: [String]!
    var objectID: String!
    var error = false

    
    @IBOutlet weak var labelNomeViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var minhaTableView: UITableView!
    @IBOutlet weak var labelValor: UILabel!
    
    @IBOutlet weak var viewTitulo: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        labelNomeViagem.text = loadNomeViagem
        labelDataViagem.text = loadDataViagem
        labelValor.text = loadValorViagem
        
        viewTitulo.backgroundColor = UIColor().colorWithHexString("118CEF")
        
        
        registerNotifications()
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        print(objectID)

        

        
        
    }
    
    private func registerNotifications() -> Void {
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    
    
    //MARK: Keyboard treatments
    func keyboardDidShow(sender: NSNotification) {
        let targetPointOffset: CGFloat = 44
        let adjustedViewFrameCenter: CGPoint = CGPointMake(self.view.center.x, self.view.center.y - targetPointOffset)
        UIView.animateWithDuration(0.2, animations:  {
            self.view.center = adjustedViewFrameCenter
        })
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let targetPointOffset: CGFloat = 44
        let adjustedViewFrameCenter: CGPoint = CGPointMake(self.view.center.x, self.view.center.y + targetPointOffset)
        UIView.animateWithDuration(0.2, animations: {
            self.view.center = adjustedViewFrameCenter
        })
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return info.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TMPagamento2TableViewCell
        
        cell.labelTitulo.text = info[indexPath.row]
        cell.textInfo.placeholder = infoPlaceholder[indexPath.row]
        
        return cell
    }
    
    
    

    @IBAction func cancelar(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
    @IBAction func acaoDoar(sender: AnyObject)
    {
        vetor = [String]()
        
        print("DOARRRR")
    
        // varrendo cada posição do vetor
        for i in 0...4 {
            
            
            if let m = self.minhaTableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) {
                
                print(m)
                
                let cell = m as! TMPagamento2TableViewCell
                
                print(cell)
            
                print(cell.textInfo.text)
                
                if(cell.textInfo.text != ""){
                    vetor.append(cell.textInfo.text!)
                } else {
                    error = true
                }
                
                
            } else {
                print("Ta vazio !!!")
            }
            
        }
        
        
        if !error
        {
            let card = STPCard()
            
            // verificando se data de validade do cartão está vazia
            if vetor[3].isEmpty == false
            {
                let expirationDate = vetor[3].componentsSeparatedByString("/")
                let expMonth: NSNumber = Int(expirationDate[0])!
                let expYear: NSNumber = Int(expirationDate[1])!
                
                // informações do cartão
                card.name = vetor[0]
                card.number = vetor[1]
                card.cvc = vetor[4]
                card.addressLine1 = vetor[2]
                card.expMonth = expMonth.unsignedLongValue
                card.expYear = expYear.unsignedLongValue
            }
            
            var underlyingError: NSError?
            do {
                try card.validateCardReturningError()
            } catch let error as NSError {
                underlyingError = error
            }
            if underlyingError != nil {
                self.handleError(underlyingError!)
                return
            }
            
            STPAPIClient.sharedClient().createTokenWithCard(card, completion: { (token, error) -> Void in
                
                if error != nil {
                    self.handleError(error!)
                    return
                }
                
                self.postStripeToken(token!)
            })

        }
    
        // SALVANDO NO PARSE
        let query = PFQuery(className: "Trip")
        query.whereKey("objectId", containsString: objectID)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
        if error == nil
        {
//            var coletado = object?.valueForKey("Coletado") as! Int
            let inc = Int(self.labelValor.text!)!
            object?.incrementKey("Coletado", byAmount: Int(inc))
//            object!["Coletado"] = coletado
//            
            object?.saveInBackgroundWithBlock({ (success, error) -> Void in
                if success
                {
                    print("SALVO!!!")
                }
                else
                {
                    print(error)
                }
            })
        }
        else
        {
                print(error)
        }
    }
    
    
    }
    
    func handleError(error: NSError)
    {
        print(error)
        UIAlertView(title: "Por favor, tente novamente",
            message: error.localizedDescription,
            delegate: nil,
            cancelButtonTitle: "OK").show()
        
    }
    
    func postStripeToken(token: STPToken)
    {
        
        let URL = "http://192.168.0.15/tripme/payment.php"
        let params = ["stripeToken": token.tokenId, "amount": Int(self.labelValor.text!)!, "currency": "usd", "description": self.labelNomeViagem.text!]
        
        let manager = AFHTTPRequestOperationManager()
        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
            
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                    message: response["message"],
                    delegate: nil,
                    cancelButtonTitle: "OK").show()
            }
            
            }) { (operation, error) -> Void in
                self.handleError(error!)
                print("ERRO!!!")
        }
    }



}
