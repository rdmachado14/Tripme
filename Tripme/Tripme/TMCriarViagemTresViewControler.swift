//
//  TMCriarViagemTresViewControler.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Foundation

class TMCriarViagemTresViewControler: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    
    var verificador = false
    //var descricaoTeste = String()
    var selectedIndexPath: NSIndexPath?
    let strings = [
        "Custo com passagens",
        "Custo com alimentação",
        "Custo com hospedagem",
        "Custo com lazer",
        "Custo com saúde"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        let indexPathe: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        if verificador == true {
            self.tableView(myTable, didSelectRowAtIndexPath: indexPathe)
        }
    }
}

extension TMCriarViagemTresViewControler: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var customCel = UITableViewCell()
        
        let customCell: TMCriarViagemTresTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TMCriarViagemTresTableViewCell
        print(indexPath.row)
            customCell.tfTextField.placeholder = self.strings[indexPath.row]
            
            customCel = customCell
        
        return customCel
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("header") as! TMCriarViagemTresViewHeader
        cell.HeaderName = "Despesas da viagem"
        cell.backgroundColor = UIColor().azulCriarViagem
        return cell
    }
}

extension TMCriarViagemTresViewControler: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        let indexPaths : Array<NSIndexPath> = []
        
        print(indexPaths.count)
        
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}