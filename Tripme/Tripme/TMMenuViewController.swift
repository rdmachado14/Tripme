//
//  TMMenuViewController.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse

class TMMenuViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    @IBOutlet weak var lbSecondName: UILabel!
    
    
    
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
        return trips.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let currentUser = PFUser.currentUser()
        let cell:TMMenuItensCell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TMMenuItensCell
        
        cell.trips = self.trips[indexPath.item]
        if currentUser!["foto"] != nil {
            let imageFile  = currentUser!["foto"]//imageObject.objectForKey("foto") as! PFFile
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if error == nil {
                    
                    cell.UserImg.image = UIImage(data: data!)
                    cell.UserImg.layer.cornerRadius = cell.UserImg.frame.width/2
                    cell.UserImg.clipsToBounds = true
                    
                }
                
            }
        }
        //cell.featuredImageView.im
        cell.Nome.text = (currentUser!["primeiroNome"] as! String)
        cell.lbLocal.text = (currentUser!["localidade"] as! String)
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
        //print(indexPath.row)
    }
}