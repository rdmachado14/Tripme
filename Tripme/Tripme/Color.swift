//
//  Color.swift
//  Tripme
//
//  Created by leonardo fernandes farias on 18/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    var azulEscuro: UIColor {
        return UIColor(red: 13/255, green: 46/255, blue: 84/255, alpha: 1)
    }
    
    var vemelho: UIColor {
        return UIColor(red: 251/255, green: 50/255, blue: 79/255, alpha: 1)
    }
    
    var azulClaro: UIColor {
        return UIColor(red: 17/255, green: 139/255, blue: 237/255, alpha: 1)
    }
    
    var roxo: UIColor {
        return UIColor(red: 67/255, green: 26/255, blue: 140/255, alpha: 1)
    }
    
    var verdeEscuro: UIColor {
        return UIColor(red: 7/255, green: 190/255, blue: 152/255, alpha: 1)
    }
    
    var amareloEscuro: UIColor {
        return UIColor(red: 249/255, green: 168/255, blue: 37/255, alpha: 1)
    }
    
    var azulCriarViagem: UIColor {
        return UIColor(red: 21/255, green: 118/255, blue: 236/255, alpha: 1)
    }
    
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}