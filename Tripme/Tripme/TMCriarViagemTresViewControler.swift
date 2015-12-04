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
        
            let customCell = tableView.dequeueReusableCellWithIdentifier("cell2") as! TMCriarViagemTresTableViewCell
            customCell.tfTextField.placeholder = self.strings[indexPath.row]
            
            customCel = customCell
        
        return customCel
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        tableView.headerViewForSection(0)?.backgroundColor = UIColor().azulCriarViagem
        tableView.headerViewForSection(0)?.tintColor = UIColor.whiteColor()
    }
}

extension TMCriarViagemTresViewControler: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Informações gerais"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TMCriarViagemTresCell.defaultHeight
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
        
        //descricaoTeste = TMCriarViagemTresCell.teste
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}