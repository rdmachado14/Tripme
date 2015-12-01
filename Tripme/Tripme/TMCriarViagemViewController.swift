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
    let strings = ["Dê um nome a sua viagem", "Motivo da sua viagem", "Descrição da viagem", "Valor a ser arrecadado", "Data limite de arrecadação", "Quantidade de dias que pretende viajar"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        print("printou")
        let indexPathe: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        if verificador == true {
            self.tableView(myTable, didSelectRowAtIndexPath: indexPathe)
        }
        
//        myTable.reloadRowsAtIndexPaths([indexPathe], withRowAnimation: UITableViewRowAnimation.Automatic)

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
        return 6
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Informações gerais"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        tableView.headerViewForSection(0)?.backgroundColor = UIColor.blackColor().azulCriarViagem
        tableView.headerViewForSection(0)?.tintColor = UIColor.whiteColor()
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