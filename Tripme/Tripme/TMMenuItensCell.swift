//
//  TMMenuItensCell.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMMenuItensCell: UICollectionViewCell
{
    // MARK: - Public API
    var trips: Trips!{
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: - Private
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    private func updateUI()
    {
        interestTitleLabel?.text! = trips.title
        featuredImageView?.image! = trips.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
