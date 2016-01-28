//
//  TMPagamento1ViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/21/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMPagamento1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    let opcoes = ["R$ 1,00", "R$ 5,00", "R$ 10,00", "Outros valores"]

    @IBOutlet weak var minhaTableView: UITableView!
    @IBOutlet weak var labelNomeViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var viewTitulo: UIView!
    
    var loadNomeViagem: String!
    var loadDataViagem: String!
    var loadValorViagem: String!
    var objectID: String!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        labelNomeViagem.text = loadNomeViagem
        labelDataViagem.text = loadDataViagem
        
        viewTitulo.backgroundColor = UIColor().colorWithHexString("118CEF")

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
    
    // enviando a informação escolida para a outra view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "seguePagamento2"
        {
            let viewController: TMPagamento2ViewController! = segue.destinationViewController as! TMPagamento2ViewController
            
            viewController.loadDataViagem = loadDataViagem
            viewController.loadNomeViagem = loadNomeViagem
            viewController.loadValorViagem = loadValorViagem
            viewController.objectID = objectID
            
            
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TMPagamento1TableViewCell
        
        cell.labelInfo.text = opcoes[indexPath.row]
        cell.flag = indexPath.row
        
        if indexPath.row == 0
        {
            cell.textFieldOutrosValores.hidden = true
        }
        else if indexPath.row == 1
        {
            cell.textFieldOutrosValores.hidden = true
        }
        else if indexPath.row == 2
        {
            cell.textFieldOutrosValores.hidden = true
        }
        else if indexPath.row == 3
        {
            cell.textFieldOutrosValores.hidden = true
        }
     
        return cell
    }
    
    // carregando o valor selecionado
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TMPagamento1TableViewCell
        
        cell.botaoSelecionado.setImage(UIImage(named: "Selecionado"), forState: .Normal)
        
        if indexPath.row == 0
        {
            loadValorViagem = "1"

        }
        else if indexPath.row == 1
        {
            loadValorViagem = "5"
        }
        else if indexPath.row == 2
        {
            loadValorViagem = "10"
        }
        else
        {
//            loadValorViagem = "Outros valores"
            cell.textFieldOutrosValores.hidden = false
            
            loadValorViagem = cell.textFieldOutrosValores.text
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TMPagamento1TableViewCell
        
        cell.botaoSelecionado.setImage(UIImage(named: "Não selecionado"), forState: .Normal)
        
        if indexPath.row == 3
        {
            cell.textFieldOutrosValores.hidden = true
        }
    }



}
