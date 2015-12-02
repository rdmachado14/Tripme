//
//  TMCriarViagem2ViewController.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 02/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMCriarViagem2ViewController: UIViewController {

    @IBOutlet weak var myCollection: UICollectionView!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var lbHeader: UILabel!
    @IBOutlet weak var add: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbHeader.backgroundColor = UIColor.blackColor().azulCriarViagem
        
        add.backgroundColor = UIColor.blackColor().azulCriarViagem
        add.layer.cornerRadius = 4
        
        myCollection.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func voltar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func adicionar(sender: AnyObject) {
        
        myCollection.hidden = false
    }
    


}

extension TMCriarViagem2ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell: TMCriarViagemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellectionCell", forIndexPath: indexPath) as! TMCriarViagemCollectionViewCell
        return cell
    }
    
    
}
