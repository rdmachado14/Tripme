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
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lbLocal: UILabel!
    @IBOutlet weak var Nome: UILabel!
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var FAvorite: UIImageView!
    @IBOutlet weak var DinheiroAtual: UILabel!
    @IBOutlet weak var DinheiroTotal: UILabel!
    
    var Total: Float!
    var ATUAL: Float!
    
    private func updateUI()
    {
        //interestTitleLabel?.text! = trips.title
        //featuredImageView?.image! = trips.featuredImage
        //print("")
        //print(Float(trips.dinheiroAtual)!/Float(trips.dinheiroTotal)!)
        //print("")
        //progressView.progress = Float(trips.dinheiroAtual)!/Float(trips.dinheiroTotal)!
        lbLocal.text = trips.local
        DinheiroAtual.text = trips.dinheiroAtual
        //DinheiroTotal.text = trips.dinheiroTotal
        UserImg.image = trips.UserImg
        Nome.text = trips.Nome
        if(trips.Favorite.boolValue){
            FAvorite.image = UIImage(named: "icon-heart")
        }else{
            FAvorite.image = UIImage(named: "icon-heart-stroke")
        }
        
    }
    
    func progressViewAction(){
        progressView.setProgress(ATUAL/Total, animated: true)
    }
    
    @IBAction func FavoriteClicked(sender: AnyObject) {
        if(FAvorite.image == UIImage(named: "icon-heart")){
            FAvorite.growDown(0.1){
                self.FAvorite.image = UIImage(named: "icon-heart-stroke")
                self.FAvorite.growNormalSize(0.1)
            }
        } else {
            FAvorite.growUp(0.1){
                self.FAvorite.image = UIImage(named: "icon-heart")
                self.FAvorite.growNormalSize(0.1)
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
