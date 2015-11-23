//
//  TMPayPalViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/18/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMPayPalViewController: UIViewController, PayPalPaymentDelegate
{
    
    var payPalConfig = PayPalConfiguration()
    
    var environment: String = PayPalEnvironmentNoNetwork
    {
        willSet(newEnvironment)
        {
            if newEnvironment != environment
            {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true
    {
        didSet
        {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = "Tripme"
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        payPalConfig.payPalShippingAddressOption = .PayPal
        
        
        
        PayPalMobile.preconnectWithEnvironment(environment)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    // PayPal Delegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!)
    {
        print("Pagamento cancelado.")
        
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!)
    {
        print("Pagamento feito com sucesso!!")
        
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            print("Prova de pagamento: \n\(completedPayment.confirmation)")
        })
    }
    
    @IBAction func payPressed(sender: AnyObject)
    {
        let item1 = PayPalItem(name: "Viagem 1", withQuantity: 1, withPrice: NSDecimalNumber(string: "100"), withCurrency: "USD", withSku: "Viagem-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        print("aqui 1")
        
        // Detalhes do pagamento
        
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Viagem 01", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if payment.processable
        {
            print("aqui 2")
            
            
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
        
            
            print("\n \n \n")
            
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else
        {
            print("Pagamento nao processado: \(payment)")
        }
    }

   

}
