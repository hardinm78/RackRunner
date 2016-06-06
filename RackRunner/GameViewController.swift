//
//  GameViewController.swift
//  RackRunner
//
//  Created by Michael Hardin on 6/1/16.
//  Copyright (c) 2016 Michael Hardin. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

var soundOn = true


class GameViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var gLevelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-6381417154543225/3077757597"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.size = CGSize(width: 1536, height: 2048)
            
            scene.scaleMode = .ResizeFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet weak var soundBtn: UIButton!

    @IBAction func soundBtnTapped(sender: UIButton) {
        if soundOn{
        soundBtn.setImage(UIImage(named:"off"), forState: .Normal)
            soundOn = false
        }else {
          soundBtn.setImage(UIImage(named:"on"), forState: .Normal)
            soundOn = true
        }
    }

}
