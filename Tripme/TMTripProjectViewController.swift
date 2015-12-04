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
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var mtTableView2: UITableView!
    
    
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
        
        objectsArray = [
            Objects(
                sectionName: "Informações sobre a viagem",
                sectionObjects: ["a","b","c","d","e"],
                sectionNameObjects: ["Valor a ser arrecadado","Tempo total de arrecadação","Tempo restante","Dias viajando","Valor mínimo de doação"],
                BackGroungColor:  UIColor().colorWithHexString("FB324F")
            ),
            
            Objects(
                sectionName: "Despesas da viagem",
                sectionObjects: ["Object1","Flash"],
                sectionNameObjects: ["NameOnject1","Barry Allen"],
                BackGroungColor: UIColor().colorWithHexString("431A8D")
            )
        ]
        print(objectsArray)
        

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
        
        secondImage.layer.cornerRadius = ivProfilePicture.frame.width/2
        secondImage.clipsToBounds = true
        secondImage.layer.borderWidth = 0
        
        
        
        customView()
        
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
        
        myTableView.layer.cornerRadius = 10
        myTableView.layer.masksToBounds = true
        myTableView.layer.borderColor = UIColor.grayColor().CGColor
        myTableView.layer.borderWidth = 0.5
        
        myTableView.layer.contentsScale = UIScreen.mainScreen().scale;
        myTableView.layer.shadowColor = UIColor.blackColor().CGColor;
        myTableView.layer.shadowOffset = CGSizeZero;
        myTableView.layer.shadowRadius = 5.0;
        myTableView.layer.shadowOpacity = 0.5;
        myTableView.layer.masksToBounds = false;
        myTableView.clipsToBounds = false;
        
        mtTableView2.layer.cornerRadius = 10
        mtTableView2.layer.masksToBounds = true
        mtTableView2.layer.borderColor = UIColor.grayColor().CGColor
        mtTableView2.layer.borderWidth = 0.5
        
        mtTableView2.layer.contentsScale = UIScreen.mainScreen().scale;
        mtTableView2.layer.shadowColor = UIColor.blackColor().CGColor;
        mtTableView2.layer.shadowOffset = CGSizeZero;
        mtTableView2.layer.shadowRadius = 5.0;
        mtTableView2.layer.shadowOpacity = 0.5;
        mtTableView2.layer.masksToBounds = false;
        mtTableView2.clipsToBounds = false;

        
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
            lbNameAgain.text = (currentUser!["primeiroNome"] as! String)
        }
        
        if currentUser!["ultimoNome"] != nil
        {
            lbTripHostLastName.text = (currentUser!["ultimoNome"] as! String)
            lbSecondNameAgain.text = (currentUser!["ultimoNome"] as! String)
        }
        
        if currentUser!["foto"] != nil
        {
            let imageFile  = currentUser!["foto"]
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    self.ivProfilePicture.image = UIImage(data: data!)
                    self.secondImage.image = UIImage(data: data!)
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
        var section: Int
        
        if(tableView.restorationIdentifier == "Informacoes"){
            section = 0
        } else {
            section = 1
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TMTripProjectViewCell!
        
        print(indexPath.row)
        print(objectsArray[section].sectionName)
        print(objectsArray[section].sectionNameObjects)
        print(objectsArray[section].sectionObjects)
        
        cell.lbName.text = objectsArray[section].sectionNameObjects[indexPath.row]
        cell.lbValue.text = objectsArray[section].sectionObjects[indexPath.row]

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        print(tableView.restorationIdentifier)
        
        var section2: Int
        
        if(tableView.restorationIdentifier == "Informacoes"){
            section2 = 0
        } else {
            section2 = 1
        }
        
        if(objectsArray.count != 0) {
            return objectsArray[section2].sectionNameObjects.count
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if(objectsArray.count != 0){
            return 1
        }
        
        return 0//objectsArray.count
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
        
        var section2: Int
        
        if(tableView.restorationIdentifier == "Informacoes"){
            section2 = 0
        } else {
            section2 = 1
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Header") as! TMTripProjectHeader
        cell.backgroundColor = objectsArray[section2].BackGroungColor
        
        cell.lbName.text = objectsArray[section2].sectionName
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var section2: Int
        
        if(tableView.restorationIdentifier == "Informacoes"){
            section2 = 0
        } else {
            section2 = 1
        }
        
        let retorno = objectsArray[section2].sectionName
        
        print(retorno)
        return retorno
    }
}
