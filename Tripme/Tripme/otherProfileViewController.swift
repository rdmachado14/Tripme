//
//  otherProfileViewController.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 21/01/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
class otherProfileViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var ivImagem: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var lbnomeImagem: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    var textView = UITextView()
    var recebeObjeto: PFObject!
    let strings = ["Viagens de ", "Mensagens"]
    let claseParse = ["ID"]
    var titulo = String()
    var imagem = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivImagem.image = imagem
        ivImagem.layer.cornerRadius = ivImagem.frame.width/2
        ivImagem.clipsToBounds = true
        ivImagem.layer.borderWidth = 5
        ivImagem.layer.borderColor = UIColor.whiteColor().CGColor
        myTable.tableFooterView = UIView(frame: CGRectZero)
        lbNome.text = (recebeObjeto.objectForKey("userName") as? String)!
        lbnomeImagem.text = (recebeObjeto.objectForKey("userName") as? String)!
        local.text = (recebeObjeto.objectForKey("localidade") as? String)!
        
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        textView.frame = CGRectMake(scrollViewWidth*CGFloat(1), 0,scrollViewWidth, scrollViewHeight)
        //textView.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
        textView.backgroundColor = UIColor.blackColor()
        textView.alpha = 0.5
        textView.textColor = UIColor.whiteColor()
        textView.editable = false
        textView.text = (recebeObjeto.objectForKey("userDescricao") as? String)!
        self.scrollView.addSubview(textView)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControll.currentPage = 0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func fechar(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController:TMSelecaoTableViewController = segue.destinationViewController as! TMSelecaoTableViewController
        print((recebeObjeto.objectForKey("ID") as? String)!)
        viewController.id = (recebeObjeto.objectForKey("ID") as? String)!
        viewController.classeNoParse = "ID"
        viewController.titulo = titulo
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControll.currentPage = Int(currentPage);
        // Change the text accordingly
        
        
    }

    

}


extension otherProfileViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if indexPath.row == 0 {
            cell?.textLabel?.text = "\(strings[indexPath.row])\((recebeObjeto.objectForKey("userName") as? String)!)"
        } else {
            cell?.textLabel?.text = strings[indexPath.row]
        }
        
        
        let setinha = UIImageView(image: UIImage(named: "Setinha"))
        cell?.accessoryView = setinha
        
        cell?.layer.cornerRadius = 5
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension otherProfileViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            titulo = lbnomeImagem.text!
            performSegueWithIdentifier("otherProfileTable", sender: self)
        }
        myTable.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}
