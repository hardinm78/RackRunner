//
//  TitleVC.swift
//  RackRunner
//
//  Created by Michael Hardin on 6/2/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import UIKit

class TitleVC: UIViewController {
    
    
    @IBOutlet weak var highLevelLabel: UILabel!
    var highestLevel = Int()
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("highLevel") != 0 {
            highestLevel = defaults.integerForKey("highLevel") as Int!
            
            highLevelLabel.text = "\(highestLevel)"
        }else {
            defaults.setInteger(1, forKey: "highLevel")
            
            highLevelLabel.text = "1"
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
