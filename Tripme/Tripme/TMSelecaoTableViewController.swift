//
//  TMSelecaoTableViewController.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 20/01/16.
//  Copyright © 2016 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Parse
class TMSelecaoTableViewController: UIViewController {

    var object: PFObject!
    var tripResult = [PFObject]()
    var id = String()
    @IBOutlet weak var myTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: CGRectZero)
        ParseQuerry()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController:TMTripProjectViewController = segue.destinationViewController as! TMTripProjectViewController
        viewController.object2 = self.object
        viewController.verificador = true
    }

    @IBAction func voltar(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    func ParseQuerry() {
        let currentUser = PFUser.currentUser()
        id = (currentUser?.objectId)!
        let queryParse = PFQuery(className: "Trip")
        queryParse.whereKey("ID", equalTo: id)
        queryParse.findObjectsInBackgroundWithBlock { (object: [PFObject]?, NSError) -> Void in
            if NSError == nil {
                
                // adicionando as informacoes para o array
                if let objects = object
                {
                    self.tripResult.appendContentsOf(objects)
                    print(self.tripResult)
                }
                
                // recarregando os dados
                print(self.tripResult.count)
                self.myTable.reloadData()
                
            } else {
                print(NSError?.userInfo)
            }
            
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

}

extension TMSelecaoTableViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if let value = tripResult[indexPath.section]["Viagem"] as? String
        {
            cell?.textLabel?.text = value
        }
        cell?.backgroundColor = UIColor.blackColor().azulEscuro
        let setinha = UIImageView(image: UIImage(named: "Setinha"))
        cell?.accessoryView = setinha
        
        cell?.layer.cornerRadius = 5
        //cell?.clipsToBounds = true
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tripResult.count
    }
}

extension TMSelecaoTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        self.object = tripResult[indexPath.section]
        performSegueWithIdentifier("cellSelecionada", sender: self)
        myTable.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewSection = UIView()
        viewSection.backgroundColor = UIColor.clearColor()
        return viewSection
    }
}
