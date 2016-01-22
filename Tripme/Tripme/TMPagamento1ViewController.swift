//
//  TMPagamento1ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/21/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMPagamento1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    let opcoes = ["R$ 1,00", "R$ 5,00", "R$ 10,00", "Outros valores"]

    @IBOutlet weak var minhaTableView: UITableView!
    @IBOutlet weak var labelNomeViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    
    var loadNomeViagem: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        labelNomeViagem.text = loadNomeViagem

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func cancelar(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // TABLE VIEW
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return opcoes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel?.text = opcoes[indexPath.row]
        
        
        return cell!
    }



}
