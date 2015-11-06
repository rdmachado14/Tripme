//
//  TMProfileViewCell.swift
//  Tripme
//
//  Created by Rodrigo Machado on 11/6/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMProfileViewCell: UICollectionViewCell
{
    var profileTrips: TMProfileTrips!
    {
        didSet
        {
            updateUI()
        }
        
    }
    
    
    @IBOutlet weak var lbTripName: UILabel!
    @IBOutlet weak var ivUserImage: UIImageView!
    @IBOutlet weak var lbRaisedMoney: UILabel!
    @IBOutlet weak var lbTotalMoney: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    private func updateUI()
    {
        lbTripName.text = profileTrips.tripName
        ivUserImage.image = profileTrips.imageUser
        lbRaisedMoney.text = String(profileTrips.moneyRaised)
        lbTotalMoney.text = String(profileTrips.moneyTotal)
        progressView.progress = (Float(profileTrips.moneyRaised) / Float(profileTrips.moneyTotal))
    }
    
    // fazer layout da collection
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        
    }
    
}