//
//  TMTripProjectViewController.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/24/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class TMTripProjectViewController: UIViewController
{

    
    @IBOutlet weak var ivTripImage: UIImageView!
    @IBOutlet weak var lbTripName: UILabel!
    @IBOutlet weak var ivProfilePicture: UIImageView!
    @IBOutlet weak var lbTripHost: UILabel!
    @IBOutlet weak var lbCollected: UILabel!
    @IBOutlet weak var lbTripTotal: UILabel!
    @IBOutlet weak var lbTripHostLastName: UILabel!
    @IBOutlet weak var pvTripProgress: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var lbNameAgain: UILabel!
    @IBOutlet weak var lbSecondNameAgain: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    
    var object: PFObject!
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
        var sectionNameObjects: [String]!
        var BackGroungColor: UIColor!
    }
    
    var objectsArray = [Objects]()

    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = ivTripImage {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }



    // Referência para os outlets de arrecadação e o total
    var collectedNumber = Float()
    var tripTotalNumber = Float()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        lbTripName.text = "Naboo"
        
        lbCollected.text = "1200"
        lbTripTotal.text = "2000"
        myTableView.tableFooterView = UIView(frame: CGRectZero)
        
        progressViewAction()
        
        // scroll
        scrollView.contentSize.height = 10000
        
        ivTripImage!.image = UIImage(named: imageName)
        
        // requisição de curtir
        let query = PFQuery(className: "Trip")
        query.whereKey("objectId", equalTo: "Yh44NT0Ksj")
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, NSError) -> Void in
            if NSError == nil {
                self.object = object![0]
                print(self.object)
            } else {
                print("Erro")
            }
        }
        
        ivProfilePicture.layer.cornerRadius = ivProfilePicture.frame.width/2
        ivProfilePicture.clipsToBounds = true
        ivProfilePicture.layer.borderWidth = 0
        //ivProfilePicture.layer.borderColor = UIColor.blackColor().verdeEscuro.CGColor
        
        
        customView()
        
        objectsArray = [
            Objects(
                sectionName: "Informações sobre a viagem",
                sectionObjects: ["a","b","c","d","e"],
                sectionNameObjects: ["Valor a ser arrecadado","Tempo total de arrecadação","Tempo restante","Dias viajando","Valor mínimo de doação"],
                BackGroungColor:  UIColor().colorWithHexString("FB324F")
            ),
            
            Objects(
                sectionName: "Despesas da viagem",
                sectionObjects: ["f","g"],
                sectionNameObjects: ["Passagens aéreas","Alimentação"],
                BackGroungColor: UIColor().colorWithHexString("431A8C")
            )
        ]

        
        
    }
    
    func customView()
    {
        // view 1
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        view1.layer.borderColor = UIColor.grayColor().CGColor
        view1.layer.borderWidth = 0.5
        
        view1.layer.contentsScale = UIScreen.mainScreen().scale;
        view1.layer.shadowColor = UIColor.blackColor().CGColor;
        view1.layer.shadowOffset = CGSizeZero;
        view1.layer.shadowRadius = 5.0;
        view1.layer.shadowOpacity = 0.5;
        view1.layer.masksToBounds = false;
        view1.clipsToBounds = false;
        
        // view 4
        view4.layer.cornerRadius = 10
        view4.layer.masksToBounds = true
        view4.layer.borderColor = UIColor.grayColor().CGColor
        view4.layer.borderWidth = 0.5
        
        view4.layer.contentsScale = UIScreen.mainScreen().scale;
        view4.layer.shadowColor = UIColor.blackColor().CGColor;
        view4.layer.shadowOffset = CGSizeZero;
        view4.layer.shadowRadius = 5.0;
        view4.layer.shadowOpacity = 0.5;
        view4.layer.masksToBounds = false;
        view4.clipsToBounds = false;
        

        
    }
    

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        let currentUser = PFUser.currentUser()
        print("esta logado: \(currentUser)")
        print("nome: \(currentUser!["primeiroNome"])")
        
        if currentUser!["primeiroNome"] != nil
        {
            lbTripHost.text = (currentUser!["primeiroNome"] as! String)
        }
        
        if currentUser!["ultimoNome"] != nil
        {
            lbTripHostLastName.text = (currentUser!["ultimoNome"] as! String)
        }
        
        if currentUser!["foto"] != nil
        {
            let imageFile  = currentUser!["foto"]
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    self.ivProfilePicture.image = UIImage(data: data!)
                }
            }
        }
        
    }

    func progressViewAction()
    {
        self.collectedNumber = NSString(string: lbCollected.text!).floatValue
        self.tripTotalNumber = NSString(string: lbTripTotal.text!).floatValue
        
        dispatch_async(dispatch_get_main_queue())
            {
                self.pvTripProgress.setProgress(self.collectedNumber/self.tripTotalNumber, animated: true)
        }
        
    }
    
    
    @IBAction func btLikeTrip(sender: AnyObject)
    {
        object.addUniqueObject((PFUser.currentUser()?.objectId)!, forKey: "Favoritos")
        object.saveInBackgroundWithBlock { (success: Bool, NSError) -> Void in
            if NSError == nil
            {
                print("sem erro!")
            }
            else
            {
                print(NSError)
            }
        }
    }
}

extension TMTripProjectViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TMTripProjectViewCell!
        
        print(indexPath.row)
        print(objectsArray[indexPath.section].sectionName)
        print(objectsArray[indexPath.section].sectionNameObjects)
        print(objectsArray[indexPath.section].sectionObjects)
        
        cell.lbName.text = objectsArray[indexPath.section].sectionNameObjects[indexPath.row]
        cell.lbValue.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return objectsArray[section].sectionNameObjects.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return objectsArray.count
    }
}

extension TMTripProjectViewController: UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:UIView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Header") as! TMTripProjectHeader
        cell.backgroundColor = objectsArray[section].BackGroungColor
        
        cell.lbName.text = objectsArray[section].sectionName
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
}
