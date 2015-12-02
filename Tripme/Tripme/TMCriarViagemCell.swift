//
//  TMCriarViagemCell.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 26/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMCriarViagemCell: UITableViewCell, UITextViewDelegate {
    
    var isObserving = false
    
    @IBOutlet weak var tvDescicao: UITextView!
    
    @IBOutlet weak var lbDescicao: UILabel!
    
    static var teste = String()
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat { get { return 44 } }
    
    
    func checkHeiht() {
        if (frame.size.height < TMCriarViagemCell.expandedHeight) {
            
            //tvTextView.text = teste
            TMCriarViagemCell.teste = tvDescicao.text
            print("testando o teste1: \(TMCriarViagemCell.teste)")
            
            tvDescicao.hidden = true
            print("entoru aqui")
            lbDescicao.hidden = false
            
            print("printadno o text view: \(TMCriarViagemCell.teste)")
        } else {
            tvDescicao.delegate = self
            tvDescicao.text = TMCriarViagemCell.teste
            tvDescicao.hidden = false
            lbDescicao.hidden = true
            
        }
        
        
        //tvTextView.hidden = (frame.size.height < textViewcell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            print("entrou aqui 3")
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            print("entrou aqui 4")
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
//    func heightForText() -> CGFloat{
//        let textView = UITextView(frame: CGRectMake(0, 0, 245, 20000))
//        //print("++++++++++++++++++++++++++++++++\(self.tvDescicao.text)")
//        textView.text = tvDescicao.text
//        print("valor do teste: \(tvDescicao.text)")
//        textView.font = UIFont(name: "Helvetica", size: 15)
//        textView.sizeToFit()
//        
//        print("\(tvDescicao.text): ", textView.frame.size.height)
//        return textView.frame.size.height
//    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            print("entrou aqui 5")
            checkHeiht()
        }
    }
}


