//
//  TMSettingsTableViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 1/5/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMSettingsTableViewController: UITableViewController {
    
    @IBOutlet var mytable: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //mytable.tableFooterView = UIView(frame: CGRectZero)
        
        settings = [
        
            Setting(header: "Perfil", arrayLabel: ["Nome", "Username", "Senha", "Email"], arrayTextField: ["Skywalker", "Luke", "NOOOO", "lukexxt@gmail.com"], image: nil, switchCase: nil),
            Setting(header: "Contas Vinculadas", arrayLabel: ["Facebook", "Twitter"], arrayTextField: nil, image: [UIImage(named: "fb")!, UIImage(named: "tt")!], switchCase: [true, false]),
            Setting(header: "Notificações", arrayLabel: ["Ativar Notifucações"], arrayTextField: nil, image: nil, switchCase: [true])
            
            
        ]

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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Profile") as! TMProfileCells
            cell.lbName.text = settings[indexPath.section].arrayLabel[indexPath.row]
            cell.tfName.text = settings[indexPath.section].arrayTextField[indexPath.row]
            
            return cell

        }
        
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Account") as! TMAccountsCells
            cell.lbAccount.text = settings[indexPath.section].arrayLabel[indexPath.row]
            cell.imImage.image = settings[indexPath.section].image[indexPath.row]
            cell.switchCase.on = settings[indexPath.section].switchCase[indexPath.row]
            
            return cell
        }
        
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Notification") as! TMNotificationCells
            cell.lbNotification.text = settings[indexPath.section].arrayLabel[indexPath.row]
            cell.switchCase.on = settings[indexPath.section].switchCase[indexPath.row]
            
            return cell

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


}
