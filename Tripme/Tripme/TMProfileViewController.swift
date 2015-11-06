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
    
    // MARK: - UICollectionViewDataSource
    private var profileTrips = TMProfileTrips.createdTrips()
    
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
    
    private struct Storyboard
    {
        static let CellIdentifier = "createdTrips"
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
        return profileTrips.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell:TMProfileViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TMProfileViewCell
        
        cell.profileTrips = self.profileTrips[indexPath.item]
        return cell
    }

}

