//
//  TMMenuViewController.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMMenuViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    // MARK: - UICollectionViewDataSource
    private var trips = Trips.createInterests()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private struct Storyboard {
        static let CellIdentifier = "Trips Cell"
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
        let cell:TMMenuItensCell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! TMMenuItensCell
        
        cell.trips = self.trips[indexPath.item]
        //cell.featuredImageView.im
        
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
        
         print(offset)
        if (offset.x < 0){
            offset = CGPoint(x: 0, y: 0)
        }else{
            
        }
        print(offset)
        print("\n")
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
    }
}

extension TMMenuViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
}
