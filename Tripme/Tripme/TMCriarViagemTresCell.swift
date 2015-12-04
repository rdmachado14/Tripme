//
//  TMCriarViagemTresCell.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 03/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit

class TMCriarViagemTresCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var tvDescicao: UITextView!
    @IBOutlet weak var lbDescicao: UILabel!
    
    class var expandedHeight: CGFloat {
        get {
            return 200
        }
    }
    
    class var defaultHeight: CGFloat {
        get {
            return 44
        }
    }
    
    var isObserving = false
    
    static var teste = String()
    
    func checkHeiht() {
        if (frame.size.height < TMCriarViagemTresCell.expandedHeight) {
            TMCriarViagemTresCell.teste = tvDescicao.text
            tvDescicao.hidden = true
            lbDescicao.hidden = false
        } else {
            tvDescicao.delegate = self
            tvDescicao.text = TMCriarViagemTresCell.teste
            tvDescicao.hidden = false
            lbDescicao.hidden = true
            
        }
    }
    
    func watchFrameChanges() {
        if !isObserving {
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
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            print("entrou aqui 5")
            checkHeiht()
        }
    }
}