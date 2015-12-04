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
    var imagens: [UIImage] = []
    var strings: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print(strings)
        lbHeader.backgroundColor = UIColor.blackColor().azulCriarViagem
        
        add.backgroundColor = UIColor.blackColor().azulCriarViagem
        add.layer.cornerRadius = 4
        
        myCollection.hidden = true
        print(imagens.count)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tela2" {
            
            let viewController:TMCriarViagemTresViewControler = segue.destinationViewController as! TMCriarViagemTresViewControler
            viewController.vetorStrings = strings
            viewController.imagens = imagens
        }
        
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
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func adicionar(sender: AnyObject) {
        
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
        //myCollection.hidden = false
        
    }
    
    func openCamera() {
        let picker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        }
        else {
            openGallery()
        }
    }
    
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func proximo(sender: AnyObject) {
        performSegueWithIdentifier("tela2", sender: self)
    }
    


}


extension TMCriarViagem2ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("testando a foto: \(image)")
        imagens.append(image)
        myCollection.hidden = false
        myCollection.reloadData()

        //imageHolderButton.setImage(image, forState: .Normal)
    }
    
}

extension TMCriarViagem2ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell: TMCriarViagemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellectionCell", forIndexPath: indexPath) as! TMCriarViagemCollectionViewCell
        cell.ivImagem.image = imagens[indexPath.row]
        return cell
    }
    
    
}
