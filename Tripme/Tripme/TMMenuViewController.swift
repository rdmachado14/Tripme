//
//  TMMenuViewController.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse


protocol ShowDetailDelegate {
    func showDetail(displayText:PFObject, imagem: UIImage)
}

class TMMenuViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    @IBOutlet weak var lbSecondName: UILabel!
    
    var tripResult = [PFObject]()
    var object: PFObject!
    
    var imagens: [UIImage]!
    var imagem = UIImage()
    // MARK: - UICollectionViewDataSource
    private var trips = Trips.createInterests()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    
    @IBOutlet weak var perfilImagem: UIImageView!
    
    @IBOutlet weak var nuvens1: UIImageView!
    @IBOutlet weak var nuvens2: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        nuvens1.goLeftAndAgain(10)
        nuvens2.goLeftAndAgain(5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let currentUser = PFUser.currentUser()
        self.view.backgroundColor = UIColor().colorWithHexString("118DF0")
        
        
        
        if currentUser!["foto"] != nil {
            let imageFile  = currentUser!["foto"]//imageObject.objectForKey("foto") as! PFFile
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    self.perfilImagem.image = UIImage(data: data!)
                }
            }
        }
        perfilImagem.layer.cornerRadius = perfilImagem.frame.width/2
        perfilImagem.clipsToBounds = true
        //        perfilImagem.layer.borderWidth = 1
        //        perfilImagem.layer.borderColor = UIColor.whiteColor().CGColor
        loadParse()
        //queryParse()
        
        collectionView.window?.makeKeyWindow()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue)
        if segue.identifier == "descricaoPelaCollection" {
        let viewController:TMTripProjectViewController = segue.destinationViewController as! TMTripProjectViewController
            viewController.object2 = self.object
            viewController.verificador = true
        } else if segue.identifier == "otherProfile"{
            let viewController:otherProfileViewController = segue.destinationViewController as! otherProfileViewController
            viewController.recebeObjeto = self.object
            viewController.imagem = self.imagem
        }
    }
    
    func loadParse() {
        let queryParse = PFQuery(className: "Trip")
        queryParse.findObjectsInBackgroundWithBlock { (object: [PFObject]?, NSError) -> Void in
            if NSError == nil {
                
                // adicionando as informacoes para o array
                if let objects = object
                {
                    self.tripResult.appendContentsOf(objects)
                    print(self.tripResult)
                }
                
                // recarregando os dados
                self.collectionView.reloadData()
                
            } else {
                print(NSError?.userInfo)
            }
            
        }
    
    }
    
    func queryParse()
    {
        print("AQUIII")
        let queryViagem = PFQuery(className: "Trip")
        
        if searchBar.text != ""
        {
            tripResult.removeAll(keepCapacity: true)
            queryViagem.whereKey("Viagem", containsString: searchBar.text?.lowercaseString)
        }
        
        queryViagem.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil
            {
                print("Aqui 22222")
                self.collectionView.reloadData()
                
                if let objects = object
                {
                    print("Aqui 33333")
                    self.tripResult.appendContentsOf(objects)
                }
            }
            else
            {
                print(error)
            }
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder() // tira o teclado
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        print("1")
        searchBar.resignFirstResponder()
        queryParse()
        
    }
    
    
    private struct Storyboard {
        static let CellIdentifier = "Trips Cell"
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}



extension TMMenuViewController : UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return tripResult.count
        //return trips.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell:TMMenuItensCell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TMMenuItensCell
        if let localDestino = tripResult[indexPath.row]["Viagem"] as? String {
            cell.interestTitleLabel.text = localDestino
        }
        
        if let valorTotal = tripResult[indexPath.row]["Valor"] as? String {
            cell.DinheiroTotal.text = "Total de R$ \(valorTotal)"
        }
        
        if let local = tripResult[indexPath.row]["localidade"] as? String {
            cell.lbLocal.text = local
        }
        
        if let nome = tripResult[indexPath.row]["userName"] as? String {
            cell.Nome.text = nome
        }
        
        if let value = tripResult[indexPath.row]["Viagem"] as? String
        {
            cell.interestTitleLabel.text = value
        }
        cell.id = (PFUser.currentUser()?.objectId)!
        cell.objeto = tripResult[indexPath.row]
        
        let transform:CGAffineTransform = CGAffineTransformMakeScale(1.0, 3.0);
        cell.progressView.transform = transform;
        cell.progressView.layer.cornerRadius = 4.5
        cell.progressView.clipsToBounds = true
        cell.showDetailDelegate = self
        
        
        if let finalImage = tripResult[indexPath.row]["Foto0"] as? PFFile {
        
            finalImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            
                if error == nil
                {
                    if let imageData = imageData
                    {
                        cell.featuredImageView.image = UIImage(data: imageData)
                    
                    }
                }
            })
        }
        
        if let userFoto = tripResult[indexPath.row]["personFoto"] as? PFFile {
            
            userFoto.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                
                if error == nil
                {
                    if let imageData = imageData
                    {
                        cell.UserImg.image = UIImage(data: imageData)
                        cell.UserImg.layer.cornerRadius = cell.UserImg.frame.width/2
                        cell.UserImg.clipsToBounds = true
                        
                    }
                }
            })
        }
        
        return cell
    }
}

extension TMMenuViewController : UIScrollViewDelegate
{
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.memory
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        // print(offset)
        if (offset.x < 0){
            offset = CGPoint(x: 0, y: 0)
        }else{
            
        }
       // print(offset)
        //print("\n")
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
    }
}

extension TMMenuViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let objeto = tripResult[indexPath.row]
        self.object = objeto
        
//        for i in 0..<4 {
//            
//            if let userFoto = object.objectForKey("Foto\(i)") as? PFFile {
//                print("oi")
////                userFoto.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
////                    
////                    if error == nil
////                    {
////                        if let imageData = imageData
////                        {
////                            self.imagens.append(UIImage(data: imageData)!)
////                            
////                        }
////                    }
////                })
//            }
//            print(imagens.count)
////            if (object.objectForKey("Foto\(i)") != nil) {
////                
////            }
//        }
        performSegueWithIdentifier("descricaoPelaCollection", sender: self)
        //print(indexPath.row)
    }
}


extension TMMenuViewController : ShowDetailDelegate {
    func showDetail(displayText:PFObject, imagem: UIImage){
        //print("oshi diaxo: \(displayText)")
        self.object = displayText
        self.imagem = imagem
        performSegueWithIdentifier("otherProfile", sender: self)
    }
}