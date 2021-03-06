//
//  TMSettingsTableViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/5/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMSettingsTableViewController: UITableViewController {
    
    @IBOutlet var mytable: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        settings = [
        
            Setting(header: "Perfil", arrayLabel: ["Nome", "Username", "Senha", "Email"], arrayTextField: ["Skywalker", "Luke", "NOOOO", "lukexxt@gmail.com"], image: nil, switchCase: nil),
            Setting(header: "Contas Vinculadas", arrayLabel: ["Facebook", "Twitter"], arrayTextField: nil, image: [UIImage(named: "fb")!, UIImage(named: "tt")!], switchCase: [true, false]),
            Setting(header: "Notificações", arrayLabel: ["Ativar notificações"], arrayTextField: nil, image: nil, switchCase: [true]),
            Setting(header: "", arrayLabel: ["Sair"], arrayTextField: [""], image: nil, switchCase: nil)
            
            
        ]

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    struct Setting
    {
        var header: String!
        var arrayLabel: [String]!
        var arrayTextField: [String]!
        var image: [UIImage]!
        var switchCase: [Bool]!
        
    }
    
    var settings: [Setting]!

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return settings.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settings[section].arrayLabel.count
    }
    
    

    @IBAction func voltar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Profile") as! TMProfileCells
            cell.lbName.text = settings[indexPath.section].arrayLabel[indexPath.row]
//            cell.tfName.text = settings[indexPath.section].arrayTextField[indexPath.row]
            
            let currentUser = PFUser.currentUser()
            
            if currentUser!["primeiroNome"] != nil && indexPath.row == 0
            {
                cell.tfName.text = (currentUser!["primeiroNome"] as! String)
            }
            
            else if currentUser!["username"] != nil && indexPath.row == 1
            {
                cell.tfName.text = (currentUser!["username"] as! String)
            }
            
            else if indexPath.row == 2
            {
//                cell.tfName.text = (currentUser!["password"] as! String)
                cell.tfName.secureTextEntry = true
            }
            
            else
            {
                cell.tfName.text = (currentUser!["email"] as! String)
            }
            
            return cell

        }
        
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Account") as! TMAccountsCells
            cell.lbAccount.text = settings[indexPath.section].arrayLabel[indexPath.row]
            cell.imImage.image = settings[indexPath.section].image[indexPath.row]
            
            let currentUser = PFUser.currentUser()
            
            let object = PFObject(className: "User")
            
            
            if currentUser!["statusRede"] != nil && indexPath.row == 0
            {
                cell.switchCase.on = true
            }
            
            else
            {
                cell.switchCase.on = false
            }

            
            
            return cell
        }
        
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Notification") as! TMNotificationCells
            cell.lbNotification.text = settings[indexPath.section].arrayLabel[indexPath.row]
            cell.switchCase.on = settings[indexPath.section].switchCase[indexPath.row]
            
            
            
            
            return cell

        }
        
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Quit") as! TMQuitCells
            
            cell.lblogOut.text = settings[indexPath.section].arrayLabel[indexPath.row]
            
            
            return cell

        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {

        
        if indexPath.section == 3 && indexPath.row == 0
        {
            PFUser.logOut()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let view: TMInitialViewController = sb.instantiateViewControllerWithIdentifier("begin") as! TMInitialViewController
            presentViewController(view, animated: true, completion: nil)
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return settings[section].header
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Header") as! TMHeaderCells
        
        cell.lbHeaderCell.text = settings[section].header
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    @IBAction func btSave(sender: AnyObject)
    {
        let user = PFUser.currentUser()
        
        for i in 0...3
        {
            
        
            let celula: TMProfileCells = mytable.cellForRowAtIndexPath(NSIndexPath(forItem: i, inSection: 0)) as! TMProfileCells
        
            if i == 0 {
                user!["primeiroNome"] = celula.tfName.text
            } else if i == 1 {
                user!["username"] = celula.tfName.text
            } else if i == 2 {
                user!["password"] = celula.tfName.text
            } else if i == 3 {
                user!["email"] = celula.tfName.text
            }
            
            
        }
        
        user!.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success
            {
                print("salvo 1")
            }
            else
            {
                print(error)
            }
        })
        
        ///////////////////////////////////////////////////////////////
        
        for i in 0...1
        {
            let celula: TMAccountsCells = mytable.cellForRowAtIndexPath(NSIndexPath(forItem: i, inSection: 1)) as! TMAccountsCells
            
            if i == 0
            {
                user!["statusRede"] = celula.switchCase.on
            }
            else
            {
                print("Nada")
            }

        }
        
        user?.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success
            {
                print("salvo 2")
            }
            else
            {
                print("ERRO: \(error)")
            }
        })
        
            
        
        
        
        

    }
    


}
