//
//  TMProfileViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/5/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse


class TMProfileViewController: UIViewController
{
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var lbFacebookLocation: UILabel!
    
    
    // MARK: - UICollectionViewDataSource
    //private var profileTrips = TMProfileTrips.createdTrips()
    
    override func viewDidAppear(animated: Bool)
    {
        
        
        let currentUser = PFUser.currentUser()
        print("esta logado: \(currentUser)")
        print("nome: \(currentUser!["primeiroNome"])")
        
        if currentUser!["primeiroNome"] != nil {
            nome.text = (currentUser!["primeiroNome"] as! String)
        }
        
        if currentUser!["localidade"] != nil {
            self.lbFacebookLocation.text = (currentUser!["localidade"] as! String)
        }
        
        if currentUser!["foto"] != nil {
            let imageFile  = currentUser!["foto"]//imageObject.objectForKey("foto") as! PFFile
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    self.img.image = UIImage(data: data!)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.layer.cornerRadius = img.frame.width/2
        img.clipsToBounds = true
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor.blackColor().verdeEscuro.CGColor
    
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    private struct Storyboard
    {
        static let CellIdentifier = "createdTrips"
    }
    
    
    @IBAction func fechar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension TMProfileViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if indexPath.section == 0 {
            cell?.textLabel?.text = "Minhas viagens"
            cell?.backgroundColor = UIColor.brownColor().azulEscuro
        } else if indexPath.section == 1 {
            cell?.textLabel?.text = "Viagens que eu ajudei"
            cell?.backgroundColor = UIColor.redColor().vemelho
        } else if indexPath.section == 2 {
            cell?.textLabel?.text = "Viagens que gostei"
            cell?.backgroundColor = UIColor.blackColor().azulClaro
        } else if indexPath.section == 3 {
            cell?.textLabel?.text = "Desempenho"
            cell?.backgroundColor = UIColor.blueColor().roxo
        } else if indexPath.section == 4 {
            cell?.textLabel?.text = "Mensagens"
            cell?.backgroundColor = UIColor.blackColor().amareloEscuro
        }
        
        cell?.layer.cornerRadius = 5
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
}

extension TMProfileViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    
    
}


