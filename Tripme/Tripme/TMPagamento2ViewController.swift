//
//  TMPagamento2ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/25/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMPagamento2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    let info = ["Nome", "Número do cartão", "C.E.P.", "Validade", "Código de segurança"]
    var loadNomeViagem: String!
    var loadDataViagem: String!
    var vetor: [String]!
    var error = false

    
    @IBOutlet weak var labelNomeViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var minhaTableView: UITableView!
    
    
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
        
        
        return cell
    }
    
    @IBAction func cancelar(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func acaoDoar(sender: AnyObject)
    {
        vetor = []
        
        for i in 0..<5 {
            let cell: TMPagamento2TableViewCell = minhaTableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! TMPagamento2TableViewCell
            if(cell.textInfo.text != ""){
                vetor.append(cell.textInfo.text!)
            } else {
                error = true
            }
        }

    }

}
