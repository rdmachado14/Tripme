//
//  TMCriarViagemViewController.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 26/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMCriarViagemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTable: UITableView!
    var verificador = false
    var descricaoTeste = String()
    var selectedIndexPath : NSIndexPath?
    var vetorStrings: [String] = []
    let strings = ["Dê um nome a sua viagem", "Motivo da sua viagem", "Descrição da viagem", "Valor a ser arrecadado", "Data limite de arrecadação", "Quantidade de dias que pretende viajar", "Valor minimo de doação"]
    var erro = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTable.tableFooterView = UIView(frame: CGRectZero)

        myTable.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tela1" {
            
            let viewController:TMCriarViagem2ViewController = segue.destinationViewController as! TMCriarViagem2ViewController
            viewController.strings = vetorStrings
        }
        
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        print("printou")
        let indexPathe: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        if verificador == true {
            self.tableView(myTable, didSelectRowAtIndexPath: indexPathe)
        }

        
//        myTable.reloadRowsAtIndexPaths([indexPathe], withRowAnimation: UITableViewRowAnimation.Automatic)

    }
    
    
    
    
    @IBAction func priximo(sender: AnyObject) {
        erro = false
        vetorStrings = []
        for i in 0..<7 {
            if i == 2 {
                let celula2: TMCriarViagemCell = myTable.cellForRowAtIndexPath(NSIndexPath(forItem: i, inSection: 0)) as! TMCriarViagemCell
                if celula2.tvDescicao.text != "" {
                    vetorStrings.append(celula2.tvDescicao.text)
                } else {
                    erro = true
                }
            } else {
                let celula: TMCriarViagem2TableViewCell = myTable.cellForRowAtIndexPath(NSIndexPath(forItem: i, inSection: 0)) as! TMCriarViagem2TableViewCell
                if celula.tfTextField.text != "" {
                    vetorStrings.append(celula.tfTextField.text!)
                } else {
                    erro = true
                }
                
            }
        }
        
        if erro {
            let alert=UIAlertController(title: "Opa", message: "Esqueceu um campo aí", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            showViewController(alert, sender: self)
        } else {
            performSegueWithIdentifier("tela1", sender: self)
        }
        
    }
    
    
}



extension TMCriarViagemViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var customCel = UITableViewCell()
        
        if indexPath.row == 2 {
            let customCell : TMCriarViagemCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TMCriarViagemCell
            customCell.lbDescicao.text = self.strings[indexPath.row]
            customCel = customCell
            
        } else {
            let customCell: TMCriarViagem2TableViewCell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TMCriarViagem2TableViewCell
            customCell.tfTextField.placeholder = self.strings[indexPath.row]
            customCell.tfTextField.delegate = self
            customCel = customCell
        }
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        return customCel
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            (cell as! TMCriarViagemCell).watchFrameChanges()
        }
        
        
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            (cell as! TMCriarViagemCell).ignoreFrameChanges()
        }
    }
    
}







extension TMCriarViagemViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("header") as! TMCriarViagemHeader
        cell.HeaderName = "Informações gerais"
        cell.backgroundColor = UIColor.blackColor().azulCriarViagem
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Informações gerais"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            if indexPath == selectedIndexPath {
                verificador = true
                return TMCriarViagemCell.expandedHeight
            } else {
                verificador = false
                
                return TMCriarViagemCell.defaultHeight
                
            }
        } else {
            return TMCriarViagemCell.defaultHeight
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if indexPath.row == 2  {
            let celula2: TMCriarViagemCell = myTable.cellForRowAtIndexPath(indexPath) as! TMCriarViagemCell
            
            celula2.tvDescicao.becomeFirstResponder()
            
        
            print("entrou aqui nese")
            if let previous = previousIndexPath {
            indexPaths += [previous]
            }
            
            if let current = selectedIndexPath {
                indexPaths = [current]
            }
        }
        
        print(indexPaths.count)
        
        //if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic
            )
                    // }
        descricaoTeste = TMCriarViagemCell.teste
        print("olha so\(descricaoTeste)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
}