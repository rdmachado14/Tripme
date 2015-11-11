//
//  TMSearchViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/10/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    // variáveis da tela
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    // filtrar resultados da busca
    var searchResults = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }
    
    // table view methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")! as UITableViewCell
        
//        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell")
        
        cell.textLabel?.text = searchResults[indexPath.row]
        
//        myCell!.textLabel?.text = searchResults[indexPath.row]
        
//        return myCell!
        
        return cell
        
    }
    
    // search bar methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        mySearchBar.resignFirstResponder()
        
        // variáveis para percorrerem as colunas da tabela "Test"
        let firstNameTest = PFQuery(className: "Test")
        firstNameTest.whereKey("nome", containsString: searchBar.text)
        
        let lastNameTest = PFQuery(className: "Test")
        lastNameTest.whereKey("sobrenome", containsString: searchBar.text)
        
        let query = PFQuery.orQueryWithSubqueries([firstNameTest,lastNameTest])
        
        
        
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
            }
        
            if error != nil{
                
                print("Não fez o request")
            
            }else if object == nil{
            
                print("Não retornou nada")
            
            }else{
            
                self.searchResults.removeAll(keepCapacity: false)
                
                //                for object in objects {
                let firstName = object!.objectForKey("nome") as! String
                let lastName = object!.objectForKey("sobrenome") as! String
                let fullName = firstName + " " + lastName
                
                self.searchResults.append(fullName)
                
                self.myTableView.reloadData()
                
                print(self.searchResults.count)
                
            
            }
        }
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        
    }
    
    @IBAction func refreshButton(sender: AnyObject)
    {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        searchResults.removeAll(keepCapacity: false)
        myTableView.reloadData()
    }
    
}