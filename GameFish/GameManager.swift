//
//  GameManager.swift
//  GameFish
//
//  Created by admin on 10/25/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import AVFoundation

class GameManager: NSObject, AVAudioPlayerDelegate {
    var fishViews : NSMutableArray?
    var hookView : HookerView?
    var isCatch : Bool = false
    var biteMusic = AVAudioPlayer()
    
    override init() {
        self.fishViews = NSMutableArray()
        self.hookView = HookerView(frame: CGRect(x: 0, y: -490, width: 20, height: 490))
    }
    
    func addFishToviewController(viewCol : UIViewController, width : Int) -> Void {
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        fishView.generateFish(width: width)
        self.fishViews?.add(fishView)
        viewCol.view.addSubview(fishView)
    }
    
    func bite(fishView : FishView) {
        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP && self.hookView?.status != self.hookView?.CAUGHTF) {
            fishView.caught()
            
            fishView.center = CGPoint(x: (self.hookView?.center.x)!, y: (self.hookView?.frame.origin.y)! + (self.hookView?.frame.height)! + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
            //isCatch = true
            addMusic()
        }
    }
    
    func updateMove() {
        self.hookView?.updateMove()
        for fishView in self.fishViews! {
            (fishView as AnyObject).updateMove()
            
            if (((fishView as AnyObject).frame).contains(CGPoint(x: (self.hookView?.center.x)!, y: (self.hookView?.frame.origin.y)! + (self.hookView?.frame.height)! + (fishView as AnyObject).frame.width/2))) {
                //Cach2: khi bat dc ca set luon = true, khi cham vao man hinh thi set = false
                //if isCatch == false {
                    self.bite (fishView: fishView as! FishView)
                //}
            }
        }
        
    }
    
    func dropHookerAtX(x : Int) {
        self.hookView?.dropDownAtX(x: x)
        //isCatch = false
    }
    
    func addMusic() {
        let filePath = Bundle.main.path(forResource: "gunshot", ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        biteMusic = try! AVAudioPlayer(contentsOf: url)
        biteMusic.prepareToPlay()
        biteMusic.play()
    }

}
