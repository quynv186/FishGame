//
//  ViewController.swift
//  GameFish
//
//  Created by admin on 10/25/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    var gameManager : GameManager?
    var music = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToviewController(viewCol: self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(sender:))))
        
        Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager! , selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
        addMusic()
    }
    
    func tapHandle(sender: UIGestureRecognizer) {
        let tapPoint = sender.location(in: self.view)
        self.gameManager?.dropHookerAtX(x: Int(tapPoint.x))
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews {
            if (object.isKind(of: FishView.self)) {
                object.removeFromSuperview()
            }
        }
        self.gameManager?.addFishToviewController(viewCol: self, width: Int(self.view.bounds.width))
    }
    
    @IBAction func addFish(_ sender: UIButton) {
        self.gameManager?.addFishToviewController(viewCol: self, width: Int(self.view.bounds.width))
    }
    
    func addMusic() {
        let filePath = Bundle.main.path(forResource: "nhac song", ofType: "mp3")
        let url = URL(fileURLWithPath: filePath!)
        music = try! AVAudioPlayer(contentsOf: url)
        music.prepareToPlay()
        music.play()
    }

}

