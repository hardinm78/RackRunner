//
//  GameScene.swift
//  RackRunner
//
//  Created by Michael Hardin on 6/1/16.
//  Copyright (c) 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var circle = SKSpriteNode()
    var person = SKSpriteNode()
    var dot = SKSpriteNode()
    var bgImage = SKSpriteNode()
    
    var levelWord = SKSpriteNode()
    
    var path = UIBezierPath()
    
    var gameStarted = Bool()
    var movingClockwise = Bool()
    
    var intersected = false
    
    var ballHit = SKAction.playSoundFileNamed("ballshitting.wav", waitForCompletion: false)
    var win = SKAction.playSoundFileNamed("win.wav", waitForCompletion: false)
    var lose1 = SKAction.playSoundFileNamed("lose1.wav", waitForCompletion: false)
    var lose2 = SKAction.playSoundFileNamed("lose2.wav", waitForCompletion: false)
    var lose3 = SKAction.playSoundFileNamed("lose3.wav", waitForCompletion: false)
    var lose4 = SKAction.playSoundFileNamed("lose4.wav", waitForCompletion: false)
    var lose5 = SKAction.playSoundFileNamed("lose5.wav", waitForCompletion: false)
    var lose6 = SKAction.playSoundFileNamed("lose6.wav", waitForCompletion: false)
    var lose7 = SKAction.playSoundFileNamed("lose7.wav", waitForCompletion: false)
    var lose8 = SKAction.playSoundFileNamed("lose8.wav", waitForCompletion: false)
    var lose9 = SKAction.playSoundFileNamed("lose9.wav", waitForCompletion: false)
    var lose10 = SKAction.playSoundFileNamed("lose10.wav", waitForCompletion: false)
    var lose11 = SKAction.playSoundFileNamed("lose11.wav", waitForCompletion: false)
    var lose12 = SKAction.playSoundFileNamed("lose12.wav", waitForCompletion: false)
    
    var topLevelLabel = UILabel()
    var levelLabel = UILabel()
    var currentLevel = Int()
    var currentScore = Int()
    var highestLevel = Int()
    
    var ballNumber = Int()
    
    override func didMoveToView(view: SKView) {
        playSound(win)
        playSound(ballHit)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("highLevel") != 0 {
            highestLevel = defaults.integerForKey("highLevel") as Int!
            currentLevel = highestLevel
            currentScore = currentLevel
            levelLabel.text = "\(currentScore)"
        }else {
            defaults.setInteger(1, forKey: "highLevel")
            currentLevel = 1
            currentScore = 1
            levelLabel.text = "\(currentScore)"
        }
        
        
        
        
        
//        topLevelLabel = UILabel(frame: CGRectMake(self.view!.frame.size.width/3, 60, 120, 25))
//        topLevelLabel.text = "Level:\(currentLevel)"
//        topLevelLabel.textColor = UIColor.whiteColor()
//        topLevelLabel.textAlignment = NSTextAlignment.Left
//        topLevelLabel.font = UIFont(name: "Optima", size: 30)
//        self.view?.addSubview(topLevelLabel)
        
        loadView()
    }
    func loadView(){
        self.removeAllChildren()
        levelWord = SKSpriteNode(imageNamed: "Leveltext")
        levelWord.size = CGSize(width: 143, height: 48)
        levelWord.position = CGPoint(x: self.frame.width/2 , y: self.frame.height/2 + 60)
        
        levelWord.zPosition = 3.0
        self.addChild(levelWord)
        levelLabel.removeFromSuperview()
        intersected = false
        gameStarted = false
        
        bgImage = SKSpriteNode(imageNamed: "bg")
        bgImage.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
       
        bgImage.size = CGSize(width: self.frame.width, height: self.frame.height)
        print(self.frame.width)
        print(self.frame.height)
        bgImage.zPosition = -1
        self.addChild(bgImage)
        
        

        
        ballNumber = 1
        movingClockwise = true
        //backgroundColor = SKColor.whiteColor()
        circle = SKSpriteNode(imageNamed: "Circle")
        circle.size = CGSize(width: 300, height: 300)
        
        circle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(circle)
        
        person = SKSpriteNode(imageNamed: "cueBall")
        person.size = CGSize(width: 50, height: 50)
        person.position = CGPoint(x: self.frame.width/2 , y: self.frame.height/2 + 112)
        person.zRotation = 3.14 / 2
        person.zPosition = 2.0
        self.addChild(person)
        
        addDot()
        
        
        levelLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        levelLabel.center = (self.view?.center)!
        levelLabel.text = "\(currentScore)"
        levelLabel.textColor = SKColor.cyanColor()
        levelLabel.textAlignment = NSTextAlignment.Center
        levelLabel.font = UIFont(name: "JD Digital", size: 150)
        
        self.view?.addSubview(levelLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !gameStarted {
            levelWord.removeFromParent()
            moveClockwise()
            movingClockwise = true
            gameStarted = true
        }else {
            
            if movingClockwise {
                moveCounterClockwise()
                movingClockwise = false
            }else {
                moveClockwise()
                movingClockwise = true
            }
            dotTouched()
        }
        
        
    }
    
    func addDot(){
        
        switch ballNumber{
        case 1 :
            dot = SKSpriteNode(imageNamed: "oneBall")
        case 2 :
            dot = SKSpriteNode(imageNamed: "twoBall")
        case 3 :
            dot = SKSpriteNode(imageNamed: "threeBall")
        case 4 :
            dot = SKSpriteNode(imageNamed: "fourBall")
        case 5 :
            dot = SKSpriteNode(imageNamed: "fiveBall")
        case 6 :
            dot = SKSpriteNode(imageNamed: "sixBall")
        case 7 :
            dot = SKSpriteNode(imageNamed: "sevenBall")
        case 8 :
            dot = SKSpriteNode(imageNamed: "eightBall")
        case 9 :
            dot = SKSpriteNode(imageNamed: "nineBall")
        case 10 :
            dot = SKSpriteNode(imageNamed: "tenBall")
        case 11 :
            dot = SKSpriteNode(imageNamed: "elevenBall")
        case 12 :
            dot = SKSpriteNode(imageNamed: "twelveBall")
        case 13 :
            dot = SKSpriteNode(imageNamed: "thirteenBall")
        case 14 :
            dot = SKSpriteNode(imageNamed: "fourteenBall")
        case 15 :
            dot = SKSpriteNode(imageNamed: "fifteenBall")
            ballNumber = 0
        default:
            dot = SKSpriteNode(imageNamed: "sixBall")
            
            
        }
        
        //dot = SKSpriteNode(imageNamed: "oneBall")
        dot.size = CGSize(width: 50, height: 50)
        dot.zPosition = 1.0
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        if movingClockwise {
            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2,y:self.frame.height/2), radius: 112, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI*4), clockwise: true)
            dot.position = path2.currentPoint
        }else {
            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2,y:self.frame.height/2), radius: 112, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI*4), clockwise: true)
            dot.position = path2.currentPoint
        }
        self.addChild(dot)
        
    }
    
    func moveClockwise(){
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 112, startAngle: rad, endAngle: rad+CGFloat(M_PI*4), clockwise: true)
        
        let tempSpeed = CGFloat.random(min: 200, max: 600)
        //print(tempSpeed)
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: tempSpeed)
        
        person.runAction(SKAction.repeatActionForever(follow).reversedAction())
    }
    
    func moveCounterClockwise(){
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 112, startAngle: rad, endAngle: rad+CGFloat(M_PI*4), clockwise: true)
        
        //let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        let tempSpeed = CGFloat.random(min: 200, max: 600)
        //print(tempSpeed)
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: tempSpeed)
        person.runAction(SKAction.repeatActionForever(follow))
        
    }
    
    func dotTouched(){
        if intersected{
            ballNumber += 1
            dot.removeFromParent()
           
            playSound(ballHit)
           
            intersected = false
            addDot()
            currentScore -= 1
            levelLabel.text = "\(currentScore)"
            if currentScore <= 0 {
                nextLevel()
            }
            
            
        }else {
            
            died()
        }
    }
    func playSound(sound : SKAction)
    {
        if soundOn{
        runAction(sound)
        }
    }
    func nextLevel(){
        currentLevel += 1
        currentScore = currentLevel
        levelLabel.text = "\(currentScore)"
        won()
        if currentLevel > highestLevel {
            highestLevel = currentLevel
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(highestLevel, forKey: "highLevel")
            
        }
    }
    
    
    func died(){
        let rand = arc4random_uniform(12) + 1
        print(rand)
        switch rand {
        case 1:
            playSound(lose1)
        case 2:
            playSound(lose2)
        case 3:
            playSound(lose3)
        case 4:
            playSound(lose4)
        case 5:
            playSound(lose5)
        case 6:
            playSound(lose6)
        case 7:
            playSound(lose7)
        case 8:
            playSound(lose8)
        case 9:
            playSound(lose9)
        case 10:
            playSound(lose10)
        case 11:
            playSound(lose11)
        case 12:
            playSound(lose12)
        default:
            playSound(lose1)
        }
        
        
        
        self.removeAllChildren()
        
        
        let action1 = SKAction.colorizeWithColor(UIColor.orangeColor(), colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorizeWithColor(UIColor.blackColor(), colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.runAction(SKAction.sequence([action1,action2]))
        
        intersected = false
        gameStarted = false
        levelLabel.removeFromSuperview()
        currentScore = currentLevel
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.loadView()
            
        })
        
    }
    
    func won(){
        playSound(win)
        self.removeAllChildren()
        let action1 = SKAction.colorizeWithColor(UIColor.greenColor(), colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.runAction(SKAction.sequence([action1,action2]))
        
        intersected = false
        gameStarted = false
        levelLabel.removeFromSuperview()
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
         self.topLevelLabel.text = "Level:\(self.currentLevel)"
            self.loadView()
            
        })
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        if person.intersectsNode(dot){
            intersected = true
        }else{
            if intersected{
                if person.intersectsNode(dot) == false {
                    
                    died()
                }
            }
        }
    }
}
