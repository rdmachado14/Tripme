//
//  Animation.swift
//  Tripme
//
//  Created by Carlos Amadheus Souza Araujo on 30/11/15.
//  Copyright © 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

import Foundation
import UIKit

//var InitialOrigini: CGPoint!

extension UIView {
    
    
    func goLeftAndAgain(var duration: NSTimeInterval = 10.0, delay: NSTimeInterval = 0.0, destination: CGPoint = CGPoint(x: -375, y: 667), completion: (() -> Void) = { () -> Void in }) {
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            //print("x: \(destination.x), y: \(self.frame.origin.y)")
            self.frame = CGRect(x: destination.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }) { (bool : Bool) -> Void in
                self.frame.origin = CGPoint(x: 375, y: 0)
                self.goLeftAndAgain(10)
        }

    }
    
    func goLeftAndAgain2(primeiro: Bool = false,var duration: NSTimeInterval = 20.0, delay: NSTimeInterval = 0.0, destination: CGPoint = CGPoint(x: -375, y: 667), completion: (() -> Void) = { () -> Void in }) {
        
        if(primeiro) {
            duration = 10
        }
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.frame = CGRect(x: destination.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }) { (bool : Bool) -> Void in
                //print("go")
                self.frame.origin = CGPoint(x: 375, y: 43)
                self.goLeftAndAgain2(false)
        }
        
    }
    
    func goLeftAndAgainNuvem(primeiro: Bool = false,var duration: NSTimeInterval = 20.0, delay: NSTimeInterval = 0.0, destination: CGPoint = CGPoint(x: -375, y: 667), completion: (() -> Void) = { () -> Void in }) {
        
        if(primeiro) {
            duration = 10
        }
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.frame = CGRect(x: destination.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }) { (bool : Bool) -> Void in
                //print("go")
                self.frame.origin = CGPoint(x: 375, y: 206)
                self.goLeftAndAgainNuvem(false)
        }
        
    }
    
    func goLeftAndAgainNuvem2(primeiro: Bool = false,var duration: NSTimeInterval = 20.0, delay: NSTimeInterval = 0.0, destination: CGPoint = CGPoint(x: -375, y: 667), completion: (() -> Void) = { () -> Void in }) {
        
        if(primeiro) {
            duration = 10
        }
        
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.frame = CGRect(x: destination.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
            }) { (bool : Bool) -> Void in
                //print("go")
                self.frame.origin = CGPoint(x: 375, y: 100)
                self.goLeftAndAgainNuvem2(false)
        }
        
    }
    
    func growUp(duration: NSTimeInterval = 0.2, escalaX: CGFloat = 1.5, escalaY: CGFloat = 1.5,completion : (() -> Void) = {() -> Void in }){
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.transform = CGAffineTransformMakeScale(escalaX, escalaY)
        }, completion: {_ in completion()})
    }
    
    func growDown(duration: NSTimeInterval = 0.2, escalaX: CGFloat = 0.5, escalaY: CGFloat = 0.5,completion : (() -> Void) = {() -> Void in }){
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.transform = CGAffineTransformMakeScale(escalaX, escalaY)
        }, completion: {_ in completion()})
    }
    
    func growNormalSize(duration: NSTimeInterval = 0.2, completion : (() -> Void) = {() -> Void in }){
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: {_ in completion()})
    }
    
    func fadeIn(alpha: CGFloat = 1.0, duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (() -> Void) = {() -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.alpha = alpha
            }, completion: {_ in completion()})
    }
    
    
    func fadeOut(alpha: CGFloat = 0.0, duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, widht: CGFloat = 200.0, height: CGFloat = 200.0, point: CGPoint, completion: () -> Void = {() -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.alpha = alpha
            }, completion: {_ in completion()})
    }
}