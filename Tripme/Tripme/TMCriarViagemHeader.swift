//
//  TMCriarViagemHeader.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 02/12/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import Foundation
import UIKit

class TMCriarViagemHeader : UITableViewCell {
    @IBOutlet weak var headerNome: UILabel!
    
    var HeaderName = ""{
        didSet{
            headerNome.text = HeaderName
        }
    }
}
