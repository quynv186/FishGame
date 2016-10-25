//
//  FishView.swift
//  GameFish
//
//  Created by admin on 10/25/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    var status : Int?
    var speed : Int?
    var vy : Int?
    var widthFrame : Int?
    var heightFrame : Int?
    var widthFish : Int?
    var heightFish : Int?
    let moving : Int = 0
    let CAUGHT : Int = 1
    var fishes:[String] = ["fish","fish2","fish3"]
    var ifish : Int = -1
    
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateFish(width : Int) {
//        self.image = UIImage(named: "fish1")
//        self.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
        
        self.widthFrame = width
        self.vy = Int(arc4random_uniform(3)) - 1
        let y : Float = Float(arc4random_uniform(240)) + 80
        self.status = moving
        self.speed = (Int)(arc4random_uniform(5)) + 2
        
        self.ifish = (Int)(arc4random_uniform(3))
        
        if (Int(self.center.x) <= -Int(self.widthFish!/2)) {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: (UIImage(named: fishes[ifish])?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
            self.frame = CGRect(x: -CGFloat(self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
        } else {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: fishes[ifish])
            
            self.frame = CGRect(x: CGFloat(self.widthFrame! + self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            
            self.speed = -Int(self.speed!)
        }
    }
    
    func updateMove() {
        
        if (self.status == moving) {
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(vy!))
            if Int(self.center.y) < self.widthFish! || Int(self.center.y) > self.heightFish! + 240 {
                self.vy = -self.vy!
            }
            
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0) || (Int(self.center.x) < -self.widthFish! && self.speed! < 0)) {
                generateFish(width: self.widthFrame!)
            }
            
        } else if (self.status == CAUGHT) {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if (Int(self.center.y) < self.widthFish!) {
                generateFish(width: self.widthFrame!)
            }
        }
    }
    
    func caught() {
        if (self.status == moving) {
            self.status = CAUGHT

            if (self.speed! > 0) {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
            } else {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            }
        }
    }
}
