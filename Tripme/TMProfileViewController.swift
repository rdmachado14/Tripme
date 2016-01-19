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


class TMProfileViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate
{
    @IBOutlet weak var img: UIImageView!
    let recognizer = UITapGestureRecognizer()
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var lbFacebookLocation: UILabel!
    @IBOutlet weak var nuvem4: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nuvem2: UIImageView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var nuvem3: UIImageView!
    var textView = UITextView()
    var lastContentOfSet = CGFloat()
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nuvem1: UIImageView!
    
    @IBOutlet weak var configuracaoOutlet: UIButton!
    @IBOutlet weak var fecharOutlet: UIButton!
    
    
    
    
    var verificador = Bool()
    // MARK: - UICollectionViewDataSource
    //private var profileTrips = TMProfileTrips.createdTrips()
    
    override func viewWillAppear(animated: Bool)
    {
        pageControll.hidden = true
        nuvem1.goLeftAndAgain2(true)
        nuvem2.goLeftAndAgainNuvem(true)
        nuvem3.goLeftAndAgainNuvem2(false)
        nuvem4.goLeftAndAgain2(false)
        configuracaoOutlet.contentHorizontalAlignment = .Right
        fecharOutlet.contentHorizontalAlignment = .Left
        let currentUser = PFUser.currentUser()
        

        
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
        
        verificador = false
        img.layer.cornerRadius = img.frame.width/2
        img.clipsToBounds = true
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.userInteractionEnabled = true
        myTable.tableFooterView = UIView(frame: CGRectZero)
        
        recognizer.addTarget(self, action: "profileImageHasBeenTapped")
        
        img.addGestureRecognizer(recognizer)
        
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        textView.frame = CGRectMake(scrollViewWidth*CGFloat(1), 0,scrollViewWidth, scrollViewHeight)
        //textView.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        textView.backgroundColor = UIColor.blackColor()
        textView.alpha = 0.5
        textView.textColor = UIColor.whiteColor()
        textView.delegate = self
        self.scrollView.addSubview(textView)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControll.currentPage = 0
    
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        fecharOutlet.setTitle("Cancelar", forState: .Normal)
        //configuracaoOutlet.titleLabel?.text = "Salvar"
        configuracaoOutlet.setTitle("Salvar", forState: .Normal)
        
        verificador = true
        print("digitando")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func profileImageHasBeenTapped() {
        
        let alert:UIAlertController = UIAlertController(title: "Choose Image",
            message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { UIAlertAction in
            
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        let picker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        }
        else {
            openGallery()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    private struct Storyboard
    {
        static let CellIdentifier = "createdTrips"
    }
    
    
    @IBAction func configuracao(sender: AnyObject) {
        if verificador.boolValue {
            let currentUser = PFUser.currentUser()
            currentUser!["userDescricao"] = textView.text
            currentUser?.saveInBackgroundWithBlock({ (succes, error) -> Void in
                if succes {
                    
                    self.atualizaOutlet()
                } else {
                    print(error)
                }
            })
        } else {
            performSegueWithIdentifier("vaiConfiguracao", sender: self)
        }
    }
    
    @IBAction func Fechar(sender: AnyObject) {
        if verificador.boolValue {
            
            atualizaOutlet()
            
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func atualizaOutlet() {
//        self.fecharOutlet.titleLabel?.text = "Fechar"
//        self.configuracaoOutlet.titleLabel?.text = "Configurações"
        fecharOutlet.setTitle("Fechar", forState: .Normal)
        configuracaoOutlet.setTitle("Configurações", forState: .Normal)
        view.endEditing(true)
        verificador = false
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.lastContentOfSet = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        let currentUser = PFUser.currentUser()
        // Change the indicator
        self.pageControll.currentPage = Int(currentPage);
        // Change the text accordingly
        
        if self.lastContentOfSet < scrollView.contentOffset.x {
            print("moved right")
            if (currentUser!["userDescricao"] != nil) {
                print(currentUser!["userDescricao"])
                textView.text = currentUser!["userDescricao"] as! String
            }
        } else if self.lastContentOfSet > scrollView.contentOffset.x {
            print("moved left")

        }
    }
    
}

extension TMProfileViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Minhas viagens"
        } else if indexPath.row == 1 {
            cell?.textLabel?.text = "Viagens que eu ajudei"
        } else if indexPath.row == 2 {
            cell?.textLabel?.text = "Viagens que gostei"
        } else if indexPath.row == 3 {
            cell?.textLabel?.text = "Mensagens"
        }
        
        let setinha = UIImageView(image: UIImage(named: "Setinha"))
        cell?.accessoryView = setinha
        
        cell?.layer.cornerRadius = 5
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension TMProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("testando a foto: \(image)")
        
        let currentUser = PFUser.currentUser()
        let imagem: UIImage = image
        print("testando a image: \(imagem)")
        let imageData = UIImagePNGRepresentation(image)
        
        let ias:PFFile = PFFile(name: "profilePicture", data: imageData!)!
        currentUser!["foto"] = ias
        currentUser?.saveInBackground()
    }
    
}

extension TMProfileViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 57
    }
    
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView:UIView = UIView()
//        headerView.backgroundColor = UIColor.clearColor()
//        return headerView
//    }
    
    
    
}



