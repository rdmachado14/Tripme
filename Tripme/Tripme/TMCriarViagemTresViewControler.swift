//
//  TMCriarViagemTresViewControler.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Foundation
import Parse
import Parse

class TMCriarViagemTresViewControler: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var BtVoltar: UIButton!
    @IBOutlet weak var BtCancelar: UIButton!
    
    var Tela1: [String]!
    var Tela2: [UIImage]!
    var Tela3: [String]!
    var imagens: [UIImage] = []
    var vetorStrings: [String] = []
    var Erro = false
    var verificador = false
    var selectedIndexPath: NSIndexPath?
    let strings = [
        "Custo com passagens",
        "Custo com alimentação",
        "Custo com hospedagem",
        "Custo com lazer",
        "Custo com saúde"
    ]
    
    @IBAction func Voltar(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func CriarViagem(sender: AnyObject) {
        Erro = false
        Tela3 = []
        for i in 0..<5 {
            let cell: TMCriarViagemTresTableViewCell = myTable.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! TMCriarViagemTresTableViewCell
            if(cell.tfTextField.text != ""){
                Tela3.append(cell.tfTextField.text!)
            } else {
                Erro = true
                UIAlertView(title: "Opa", message: "Esqueceu um campo aí", delegate: self, cancelButtonTitle: "OK").show()            }
        }
        
        if(!Erro){
            salvarNoParse()
            ///CHAMAR UMA ACTIVITY LOG
        }else{
            ///MERDA NENHUMA
        }
        
    }
    
    func salvarNoParse(){
        
        let NewTrip = PFObject(className:"Trip")
        
        NewTrip["Viagem"]       = Tela1[0]
        NewTrip["Motivo"]       = Tela1[1]
        NewTrip["Descricao"]    = Tela1[2]
        NewTrip["Valor"]        = Tela1[3]
        NewTrip["DataLimite"]   = Tela1[4]
        NewTrip["DiasDeViagem"] = Tela1[5]
        
        
        var Fotos: [PFFile] = []
        for i in 0..<Tela2.count{
            let FotoData = UIImagePNGRepresentation(Tela2[i])
            Fotos.append(PFFile(name: "Imagens", data: FotoData!)!)
        }
        NewTrip["Fotos"] = Fotos
        
        
        NewTrip["CustoPassagem"]    = Tela3[0]
        NewTrip["CustoAlimentacao"] = Tela3[1]
        NewTrip["CustoHospedagem"]  = Tela3[2]
        NewTrip["CustoLazer"]       = Tela3[3]
        NewTrip["CustoSaude"]       = Tela3[4]

        NewTrip.saveInBackground()
    }
    
    @IBOutlet weak var Imag: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vetorStrings)
        print(imagens)
        var imagemFilesArray: [PFObject] = []
        
        let query = PFQuery(className: "capas")
        query.whereKey("objectId", equalTo: "XqVhrqa0k6")
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, NSError) -> Void in
            if NSError == nil {
                imagemFilesArray = object!
                print(object![0].objectForKey("Fotos") as! [PFFile])
                let imageFile = object![0].objectForKey("Fotos") as! [PFFile]
                print(imageFile[0])
                imageFile[0].getDataInBackgroundWithBlock { (data, error) -> Void in
                    if error == nil {
                        print(data!)
                        self.Imag.image = UIImage(data: data!)
                    }
                }
            } else {
                print("Erro na classe ComicsFavouriteCollectionView.. com o carregamenxto de imagens")
            }
        }
        
        
        
        Tela1 = ["0","1","2","3","4","5"]
        Tela2 = [UIImage(named: "r1")!, UIImage(named: "r2")!, UIImage(named: "r3")!, UIImage(named: "r4")!, UIImage(named: "r5")!]
        
        BtVoltar.setTitleColor(UIColor().CinzaClaroButtonText, forState: .Normal)
        BtCancelar.setTitleColor(UIColor().CinzaClaroButtonText, forState: .Normal)
        
        myTable.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        let indexPathe: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
        if verificador == true {
            self.tableView(myTable, didSelectRowAtIndexPath: indexPathe)
        }
    }
}

extension TMCriarViagemTresViewControler: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var customCel = UITableViewCell()
        
        let customCell: TMCriarViagemTresTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! TMCriarViagemTresTableViewCell
        print(indexPath.row)
            customCell.tfTextField.placeholder = self.strings[indexPath.row]
            
            customCel = customCell
        
        return customCel
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("header") as! TMCriarViagemTresViewHeader
        cell.HeaderName = "Despesas da viagem"
        cell.backgroundColor = UIColor().azulCriarViagem
        return cell
    }
}

extension TMCriarViagemTresViewControler: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        let indexPaths : Array<NSIndexPath> = []
        
        print(indexPaths.count)
        
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}