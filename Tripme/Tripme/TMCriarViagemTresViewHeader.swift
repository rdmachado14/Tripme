//
//  TMCriarViagemTresViewHeader.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 04/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import UIKit
import Foundation

class TMCriarViagemTresViewHeader: UITableViewCell {
    @IBOutlet weak var Header: UILabel!
    
    var HeaderName = ""{
        didSet{
            self.backgroundColor = UIColor().azulCriarViagem
            Header.text = HeaderName
        }
    }
}