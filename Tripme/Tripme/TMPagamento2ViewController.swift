//
//  TMPagamento2ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/22/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMPagamento2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    let infoCartao = ["Nome", "Número do cartão", "C.E.P", "Validade", "Código de segurança"]

    @IBOutlet weak var labelNomeViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    
    var loadNomeViagem: String!
    var loadDataViagem: String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        labelNomeViagem.text = loadNomeViagem
        labelDataViagem.text = loadDataViagem

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelar(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    // TABLE VIEW
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return infoCartao.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TMPagamento2TableViewCell
        
        cell.labelInfo.text = infoCartao[indexPath.row]
        cell.flag = indexPath.row
        
        
        
        return cell
    }
    
    




}
