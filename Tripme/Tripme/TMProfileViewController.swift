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

class TMProfileViewController: UIViewController
{
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbFacebookName: UILabel!
    @IBOutlet weak var lbFacebookLocation: UILabel!
    
    var imagem : UIImage!
    var name: String!
    var location: String!
    
    override func viewDidAppear(animated: Bool)
    {
        
        img.image = imagem
        lbFacebookName.text = name
        lbFacebookLocation.text = location
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension TMProfileViewController: UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return trips.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:TMMenuItensCell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TMMenuItensCell
        
        cell.trips = self.trips[indexPath.item]
        //cell.featuredImageView.im
        
        return cell
    }

}

extension TMProfileViewController: UICollectionViewDelegate
{
    
}

