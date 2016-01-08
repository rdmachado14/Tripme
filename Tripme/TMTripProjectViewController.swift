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
import Social
import FBSDKShareKit


class TMTripProjectViewController: UIViewController, UIScrollViewDelegate
{

    
    
    @IBOutlet weak var scrollViewImage: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lbTripName: UILabel!
    @IBOutlet weak var ivProfilePicture: UIImageView!
    @IBOutlet weak var lbTripHost: UILabel!
    @IBOutlet weak var lbCollected: UILabel!
    @IBOutlet weak var lbTripTotal: UILabel!

    @IBOutlet weak var pvTripProgress: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var lbNameAgain: UILabel!

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var mtTableView2: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    
    
    
    var arrayImagensTela:[UIImage] = []
    var arrayTela1:[String] = []
    var arrayTela3:[String] = []
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
    



    // Referência para os outlets de arrecadação e o total
    var collectedNumber = Float()
    var tripTotalNumber = Float()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        loadFromViewCriarConta()
        
        myTableView.tableFooterView = UIView(frame: CGRectZero)
        
        progressViewAction()
        
        // scroll
        print(self.scrollView.frame.height)
        scrollView.contentSize.height = 2700
        
        
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
        
        textView.editable = false
        textView2.editable = false
        
    }
    
    func loadFromViewCriarConta() {
        
        pageControl.numberOfPages = arrayImagensTela.count
        let scrollViewWidth:CGFloat = self.scrollViewImage.frame.width
        let scrollViewHeight:CGFloat = self.scrollViewImage.frame.height
        
        for i in 0..<arrayImagensTela.count {
            let imgOne = UIImageView(frame: CGRectMake(scrollViewWidth*CGFloat(i), 0,scrollViewWidth, scrollViewHeight))
            imgOne.image = arrayImagensTela[i]
            self.scrollViewImage.addSubview(imgOne)
        }
        
        self.scrollViewImage.contentSize = CGSizeMake(self.scrollViewImage.frame.width * CGFloat(arrayImagensTela.count), self.scrollViewImage.frame.height)
        self.scrollViewImage.delegate = self
        self.pageControl.currentPage = 0
        
        objectsArray = [
            Objects(
                sectionName: "Informações sobre a viagem",
                sectionObjects: [arrayTela1[3],arrayTela1[4],"c",arrayTela1[5],"e"],
                sectionNameObjects: ["Valor a ser arrecadado","Tempo total de arrecadação","Tempo restante","Dias viajando","Valor mínimo de doação"],
                BackGroungColor:  UIColor().colorWithHexString("FB324F")
            ),
            
            Objects(
                sectionName: "Despesas da viagem",
                sectionObjects: [arrayTela3[0],arrayTela3[2]],
                sectionNameObjects: ["Passagens aérias","Alimentação"],
                BackGroungColor: UIColor().colorWithHexString("431A8D")
            )
        ]
        print(objectsArray)
        
        textView.text = arrayTela1[2]
        
        
        lbTripName.text = arrayTela1[0]
        
        lbCollected.text = "900"
        lbTripTotal.text = "Total de R$ \(arrayTela1[3])"
        
    }
    
    func loadParse() {
        
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
        
        var string1 = String()
        var string2 = String()
        
        let currentUser = PFUser.currentUser()
        print("esta logado: \(currentUser)")
        print("nome: \(currentUser!["primeiroNome"])")
        
        if currentUser!["primeiroNome"] != nil
        {
            string1 = (currentUser!["primeiroNome"] as! String)

        }
        
        if currentUser!["ultimoNome"] != nil
        {
            string2 = (currentUser!["ultimoNome"] as! String)
        }
        print("\(string1) e \(string2)")
        
        lbTripHost.text = "\(string1) \(string2)"
        lbNameAgain.text = "\(string1) \(string2)"
        
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
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        
        
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
        if ((section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || section == 1) {
            cell.lbValue.text = "R$ \(objectsArray[section].sectionObjects[indexPath.row])"
        } else {
            cell.lbValue.text = objectsArray[section].sectionObjects[indexPath.row]
        }
        

        
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
    
    @IBAction func btShare(sender: AnyObject)
    {
        let shareFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        //        shareFacebook.setInitialText("") // texto inicial
        //        shareFacebook.addImage() // imagem inicial
        
        self.presentViewController(shareFacebook, animated: true, completion: nil)
    }
    
}
