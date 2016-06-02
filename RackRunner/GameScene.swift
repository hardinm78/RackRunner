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
    
    var path = UIBezierPath()
    
    var gameStarted = Bool()
    var movingClockwise = Bool()
    
    var intersected = false
    
    
    var topLevelLabel = UILabel()
    var levelLabel = UILabel()
    var currentLevel = Int()
    var currentScore = Int()
    var highestLevel = Int()
    
    var ballNumber = Int()
    
    override func didMoveToView(view: SKView) {
        
        
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
        
        topLevelLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 150, height: 100))
        topLevelLabel.text = "Level:\(currentLevel)"
        topLevelLabel.textColor = UIColor.whiteColor()
        topLevelLabel.font = UIFont(name: "Optima", size: 20)
        self.view?.addSubview(topLevelLabel)
        
        loadView()
    }
    func loadView(){
        
        intersected = false
        gameStarted = false
        
        bgImage = SKSpriteNode(imageNamed: "wood")
        bgImage.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bgImage.size = CGSize(width: self.frame.width, height: self.frame.height)
        bgImage.zPosition = -1
        self.addChild(bgImage)
        
        
        
        ballNumber = 1
        movingClockwise = true
        //backgroundColor = SKColor.whiteColor()
        circle = SKSpriteNode(imageNamed: "greenfeltCircle")
        circle.size = CGSize(width: 300, height: 300)
        circle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(circle)
        
        person = SKSpriteNode(imageNamed: "Person")
        person.size = CGSize(width: 40, height: 7)
        person.position = CGPoint(x: self.frame.width/2 , y: self.frame.height/2 + 120)
        person.zRotation = 3.14 / 2
        person.zPosition = 2.0
        self.addChild(person)
        
        addDot()
        
        
        levelLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        levelLabel.center = (self.view?.center)!
        levelLabel.text = "\(currentScore)"
        levelLabel.textColor = SKColor.whiteColor()
        levelLabel.textAlignment = NSTextAlignment.Center
        levelLabel.font = UIFont(name: "Optima", size: 60)
        self.view?.addSubview(levelLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !gameStarted {
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
            ballNumber = 0
        default:
            dot = SKSpriteNode(imageNamed: "sixBall")
            
            
        }
        
        //dot = SKSpriteNode(imageNamed: "oneBall")
        dot.size = CGSize(width: 40, height: 40)
        dot.zPosition = 1.0
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        if movingClockwise {
            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2,y:self.frame.height/2), radius: 125, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI*4), clockwise: true)
            dot.position = path2.currentPoint
        }else {
            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2,y:self.frame.height/2), radius: 125, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI*4), clockwise: true)
            dot.position = path2.currentPoint
        }
        self.addChild(dot)
        
    }
    
    func moveClockwise(){
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 120, startAngle: rad, endAngle: rad+CGFloat(M_PI*4), clockwise: true)
        
        let tempSpeed = CGFloat.random(min: 200, max: 600)
        print(tempSpeed)
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: tempSpeed)
        
        person.runAction(SKAction.repeatActionForever(follow).reversedAction())
    }
    
    func moveCounterClockwise(){
        let dx = person.position.x - self.frame.width/2
        let dy = person.position.y - self.frame.height/2
        
        let rad = atan2(dy,dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 120, startAngle: rad, endAngle: rad+CGFloat(M_PI*4), clockwise: true)
        
        //let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        
        let follow = SKAction.followPath(path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        person.runAction(SKAction.repeatActionForever(follow))
        
    }
    
    func dotTouched(){
        if intersected{
            ballNumber += 1
            dot.removeFromParent()
            
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
        self.removeAllChildren()
        
        
        let action1 = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.2)
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
