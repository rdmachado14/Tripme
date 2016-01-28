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
    
    
    let recognizer = UITapGestureRecognizer()
    var verificador = false
    var arrayImagensTela:[UIImage] = []
    var arrayTela1:[String] = []
    var arrayTela3:[String] = []
    var object: PFObject!
    var object2: PFObject!
    var likeButton: PFObject!
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
        let transform:CGAffineTransform = CGAffineTransformMakeScale(1.0, 3.0);
        pvTripProgress.transform = transform;
        pvTripProgress.layer.cornerRadius = 4.5
        pvTripProgress.clipsToBounds = true
        recognizer.addTarget(self, action: "profileImageHasBeenTapped")
        print("testando a view: \(view.frame.size)")
        print(verificador.boolValue)
        if verificador.boolValue {
            loadParse()
        } else {
            loadFromViewCriarConta()
        }
        
        
        lbTripHost.userInteractionEnabled = true
        ivProfilePicture.userInteractionEnabled = true
        //lbTripHost.addGestureRecognizer(recognizer)
        ivProfilePicture.addGestureRecognizer(recognizer)
        
        myTableView.tableFooterView = UIView(frame: CGRectZero)
        
        progressViewAction()
        
        // scroll
//        print(self.scrollView.frame.height)
//        print(view.frame.size)
        if view.frame.height == 480 {
            scrollView.contentSize.height = 2900
        } else if view.frame.height == 568 {
            scrollView.contentSize.height = 2800
        } else if view.frame.height == 667 {
            scrollView.contentSize.height = 2700
        } else {
            scrollView.contentSize.height = 2600
        }
        
        
        
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
        
        secondImage.layer.cornerRadius = secondImage.frame.width/2
        secondImage.clipsToBounds = true
        secondImage.layer.borderWidth = 0
        
        customView()
        
        textView.editable = false
        textView2.editable = false
        
    }
    
    func profileImageHasBeenTapped() {
        
        print("clicou na foto")
        performSegueWithIdentifier("otherProfile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "otherProfile" {
            let viewController:otherProfileViewController = segue.destinationViewController as! otherProfileViewController
            
            
            viewController.imagem = ivProfilePicture.image!
            viewController.recebeObjeto = object2
            
            
            
        }
        
        else if segue.identifier == "segureDoacao"
        {
            let viewController: TMPagamento1ViewController! = segue.destinationViewController as! TMPagamento1ViewController
            
            viewController.loadNomeViagem = arrayTela1[0]
            viewController.loadDataViagem = arrayTela1[4]
            
            if verificador.boolValue {
                viewController.objectID = object2.objectId!
            } else {
                viewController.objectID = object.objectId!
            }

            
        }
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func fechar(sender: AnyObject) {
        
        if verificador.boolValue {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            performSegueWithIdentifier("vaiPraLa", sender: self)
        }
    }
    
    func loadFromViewCriarConta() {
        if !verificador {
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
        }
        
        
        objectsArray = [
            Objects(
                sectionName: "Informações sobre a viagem",
                sectionObjects: [arrayTela1[3],arrayTela1[4],"c",arrayTela1[5],arrayTela1[6]],
                sectionNameObjects: ["Valor a ser arrecadado","Tempo total de arrecadação","Tempo restante","Dias viajando","Valor mínimo de doação"],
                BackGroungColor:  UIColor().colorWithHexString("FB324F")
            ),
            
            Objects(
                sectionName: "Despesas da viagem",
                sectionObjects: [arrayTela3[0],arrayTela3[1],arrayTela3[2],arrayTela3[3],arrayTela3[4]],
                sectionNameObjects: ["Passagens aéreas","Alimentação", "Hospedagem", "Lazer", "Saude"],
                BackGroungColor: UIColor().colorWithHexString("431A8D")
            )
        ]
        
        
        textView.text = arrayTela1[2]
        
        
        lbTripName.text = arrayTela1[0]
        
        lbTripTotal.text = "Total de R$ \(arrayTela1[3])"
        
        if verificador.boolValue {
            lbCollected.text = "R$" + String(object2.valueForKey("Coletado") as! NSNumber)
        } else {
            lbCollected.text = "R$ 0"
        }

    
    }
    
    func loadParse() {
        arrayTela1 = ["","","","","","",""]
        arrayTela3 = ["","","","",""]
        arrayTela1[2] = (object2.objectForKey("Descricao") as? String)!
        arrayTela1[0] = (object2.objectForKey("Viagem") as? String)!
        arrayTela1[6] = (object2.objectForKey("DoacaoMinima") as? String)!
        arrayTela1[3] = (object2.objectForKey("Valor") as? String)!
        arrayTela1[4] = (object2.objectForKey("DataLimite") as? String)!
        arrayTela1[5] = (object2.objectForKey("DiasDeViagem") as? String)!
        arrayTela3[0] = (object2.objectForKey("CustoPassagem") as? String)!
        arrayTela3[1] = (object2.objectForKey("CustoAlimentacao") as? String)!
        arrayTela3[2] = (object2.objectForKey("CustoHospedagem") as? String)!
        arrayTela3[3] = (object2.objectForKey("CustoLazer") as? String)!
        arrayTela3[4] = (object2.objectForKey("CustoSaude") as? String)!
        
        for i in 0..<4 {
            if (object2.objectForKey("Foto\(i)") != nil) {
                print("entrou")
            let userFoto = object2.objectForKey("Foto\(i)") as? PFFile
                print("oi2")
                userFoto!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    
                    if error == nil
                    {
                        if let imageData = imageData
                        {
                            self.arrayImagensTela.append(UIImage(data: imageData)!)
                            print(self.arrayImagensTela.count)
                            
                            
                            self.pageControl.numberOfPages = self.arrayImagensTela.count
                            let scrollViewWidth:CGFloat = self.scrollViewImage.frame.width
                            let scrollViewHeight:CGFloat = self.scrollViewImage.frame.height
                            
                            for i in 0..<self.arrayImagensTela.count {
                                let imgOne = UIImageView(frame: CGRectMake(scrollViewWidth*CGFloat(i), 0,scrollViewWidth, scrollViewHeight))
                                imgOne.image = self.arrayImagensTela[i]
                                self.scrollViewImage.addSubview(imgOne)
                            }
                            
                            self.scrollViewImage.contentSize = CGSizeMake(self.scrollViewImage.frame.width * CGFloat(self.arrayImagensTela.count), self.scrollViewImage.frame.height)
                            self.scrollViewImage.delegate = self
                            self.pageControl.currentPage = 0
                            
                        }
                    }
                })
        }
    }
        
        
        
//        if let userFoto = object2.objectForKey("Foto1") as? PFFile {
//            print("oi2")
//            userFoto.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
//                
//                if error == nil
//                {
//                    if let imageData = imageData
//                    {
//                        self.arrayImagensTela.append(UIImage(data: imageData)!)
//                        
//                    }
//                }
//            })
//        }
//        
//        if let userFoto = object2.objectForKey("Foto2") as? PFFile {
//            print("oi3")
//            userFoto.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
//                
//                if error == nil
//                {
//                    if let imageData = imageData
//                    {
//                        self.arrayImagensTela.append(UIImage(data: imageData)!)
//                        
//                    }
//                }
//            })
//        }
//        
//        if let userFoto = object2.objectForKey("Foto3") as? PFFile {
//            print("oi4")
//            userFoto.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
//                
//                if error == nil
//                {
//                    if let imageData = imageData
//                    {
//                        self.arrayImagensTela.append(UIImage(data: imageData)!)
//                        
//                    }
//                }
//            })
//        }
        
        
        loadFromViewCriarConta()
    }
    
    func customView()
    {
        // view 1
        //view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        //view1.layer.borderColor = UIColor.grayColor().CGColor
        //view1.layer.borderWidth = 0.5
        
        view1.layer.contentsScale = UIScreen.mainScreen().scale;
        view1.layer.shadowColor = UIColor.blackColor().CGColor;
        view1.layer.shadowOffset = CGSizeZero;
        view1.layer.shadowRadius = 5.0;
        view1.layer.shadowOpacity = 0.3;
        view1.layer.masksToBounds = false;
        view1.clipsToBounds = false;
        
        // view 4
        //view4.layer.cornerRadius = 10
        view4.layer.masksToBounds = true
        //view4.layer.borderColor = UIColor.grayColor().CGColor
        //view4.layer.borderWidth = 0.5
        
        view4.layer.contentsScale = UIScreen.mainScreen().scale;
        view4.layer.shadowColor = UIColor.blackColor().CGColor;
        view4.layer.shadowOffset = CGSizeZero;
        view4.layer.shadowRadius = 5.0;
        view4.layer.shadowOpacity = 0.3;
        view4.layer.masksToBounds = false;
        view4.clipsToBounds = false;
        
        //myTableView.layer.cornerRadius = 10
        myTableView.layer.masksToBounds = true
//        myTableView.layer.borderColor = UIColor.grayColor().CGColor
//        myTableView.layer.borderWidth = 0.5
        
        myTableView.layer.contentsScale = UIScreen.mainScreen().scale;
        myTableView.layer.shadowColor = UIColor.blackColor().CGColor;
        myTableView.layer.shadowOffset = CGSizeZero;
        myTableView.layer.shadowRadius = 5.0;
        myTableView.layer.shadowOpacity = 0.3;
        myTableView.layer.masksToBounds = false;
        myTableView.clipsToBounds = false;
        
        //mtTableView2.layer.cornerRadius = 10
        mtTableView2.layer.masksToBounds = true
//        mtTableView2.layer.borderColor = UIColor.grayColor().CGColor
//        mtTableView2.layer.borderWidth = 0.5
        
        mtTableView2.layer.contentsScale = UIScreen.mainScreen().scale;
        mtTableView2.layer.shadowColor = UIColor.blackColor().CGColor;
        mtTableView2.layer.shadowOffset = CGSizeZero;
        mtTableView2.layer.shadowRadius = 5.0;
        mtTableView2.layer.shadowOpacity = 0.3;
        mtTableView2.layer.masksToBounds = false;
        mtTableView2.clipsToBounds = false;

        
    }
    

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if verificador {
            let image = object2.objectForKey("personFoto") as? PFFile
            image?.getDataInBackgroundWithBlock({ (data , error) -> Void in
                
                if error == nil
                {
                    self.ivProfilePicture.image = UIImage(data: data!)
                    self.secondImage.image = UIImage(data: data!)
                }
            })
            let nomeString = object2.objectForKey("userName") as! String
            let descricao = object2.objectForKey("userDescricao") as! String
            
            print(nomeString)
            print(descricao)
            lbTripHost.text = nomeString
            lbNameAgain.text = nomeString
            textView2.text = descricao
            
        } else {
            var string1 = String()
            var string2 = String()
            
            let currentUser = PFUser.currentUser()
            
            
            if currentUser!["primeiroNome"] != nil
            {
                string1 = (currentUser!["primeiroNome"] as! String)
                
            }
            
            if currentUser!["ultimoNome"] != nil
            {
                string2 = (currentUser!["ultimoNome"] as! String)
            }
            
            if currentUser!["userDescricao"] != nil {
                let descricao = currentUser!["userDescricao"] as! String
                textView2.text = descricao
            }
            
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
        
        
        
        
    }
    
    
    
    @IBAction func doacao(sender: AnyObject) {
        performSegueWithIdentifier("segureDoacao", sender: self)
        
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
        
        self.tripTotalNumber = NSString(string: arrayTela1[3]).floatValue
        
        dispatch_async(dispatch_get_main_queue())
            {
                self.pvTripProgress.setProgress(self.collectedNumber/self.tripTotalNumber, animated: true)
        }
        
    }
    
    
    @IBAction func btLikeTrip(sender: AnyObject)
    {
        
        if verificador {
            likeButton = object2
        } else {
            likeButton = object
        }
        likeButton.addUniqueObject((PFUser.currentUser()?.objectId)!, forKey: "likes")
        likeButton.saveInBackgroundWithBlock { (success: Bool, NSError) -> Void in
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
        
        
        
        cell.lbName.text = objectsArray[section].sectionNameObjects[indexPath.row]
        if ((section == 0 && (indexPath.row == 0 || indexPath.row == 4)) || section == 1) {
            cell.lbValue.text = "R$ \(objectsArray[section].sectionObjects[indexPath.row])"
        } else {
            cell.lbValue.text = "\(objectsArray[section].sectionObjects[indexPath.row]) dia(s)"
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
        
        return retorno
    }
    
    @IBAction func btShare(sender: AnyObject)
    {
//        let shareFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//        
//        shareFacebook.setInitialText(lbTripName.text)
//        shareFacebook.addImage(ivProfilePicture.image)
//        
//        self.presentViewController(shareFacebook, animated: true, completion: nil)
//
        let content = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://www.globo.com/")
        content.contentTitle = lbTripName.text
        content.contentDescription = textView.text
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
        self.view.addSubview(button)
        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//        vc.setInitialText("Look at this great picture!")
//        vc.addImage(ivProfilePicture.image!)
//        presentViewController(vc, animated: true, completion: nil)
    }
}
