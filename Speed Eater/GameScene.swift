//
//  GameScene.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import SpriteKit
import GameplayKit
import ARKit
import GameKit

class GameScene: SKScene {
    
    let bite = SKAction.playSoundFileNamed("bite.mp3", waitForCompletion: false)
    let burger4 = SKTexture(image: #imageLiteral(resourceName: "burger4:4"))
    let burger3 = SKTexture(image: #imageLiteral(resourceName: "burger3:4"))
    let burger2 = SKTexture(image: #imageLiteral(resourceName: "burger2:4"))
    let burger1 = SKTexture(image: #imageLiteral(resourceName: "burger1:4"))
    var burgerImages = [SKTexture]()
    var previousBite = 0
    var viewController: UIViewController?
    var time = SKLabelNode()
    var burger = SKSpriteNode()
    var printTime = SKLabelNode()
    var timeBackground = SKSpriteNode()
    var background = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        background = childNode(withName: "background") as! SKSpriteNode
        if Stats.shared.cameraView == true {
            background.isHidden = true
        }
        burgerImages = [burger4,burger3,burger2,burger1]
        timeBackground = childNode(withName: "timeBackground") as! SKSpriteNode
        burger = childNode(withName: "burger") as! SKSpriteNode
        time = childNode(withName: "time") as! SKLabelNode
        timeBackground.isHidden = true
        time.isHidden = true
        burger.isHidden = true
        var myTime = 4
        printTime = SKLabelNode(fontNamed: "copperplate")
        func countdown() {
            myTime = myTime - 1
            if myTime == 0 {
                printTime.text = "EAT!"
            }else {
                printTime.text = String(myTime)
            }
        }
        let countdownAction = SKAction.sequence([SKAction.wait(forDuration: 1),SKAction.run(countdown)])
        
        run(SKAction.repeat(countdownAction, count: 5),completion:{
            self.printTime.isHidden = true
            self.burger.isHidden = false
            self.time.isHidden = false
            self.timeBackground.isHidden = false
            self.game()
        })
        printTime.fontSize = 150
        printTime.position = CGPoint(x: 0, y: 0)
        printTime.zPosition = 2
        printTime.fontColor = .black
        self.addChild(printTime)
    }
    
    
    func game() {
        Stats.shared.gameStarted = true
        var myTime = 30
        
        func printTimeEnd() {
            printTime.text = "Time!"
            printTime.isHidden = false
            Stats.shared.gameStarted = false
        }
        
        func countdown(){
            myTime = myTime - 1
            if myTime == 0 {
                time.text = ""
                timeBackground.isHidden = true
            }else {
                time.text = String(myTime)
            }
        }
        let endSequence =  SKAction.sequence([SKAction.run(printTimeEnd),SKAction.wait(forDuration: 2),SKAction.run {self.viewController?.performSegue(withIdentifier: "To Game Over", sender: nil)
            }])
        
        let countDownAction = SKAction.sequence([SKAction.wait(forDuration: 1),SKAction.run(countdown)])
        run(SKAction.repeat(countDownAction, count: 30),completion: {self.run(endSequence)})
        time.text = "30"
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard previousBite != Stats.shared.bite && Stats.shared.gameStarted == true else {return}
        if Stats.shared.soundEffects == true {
        run(bite)
        }
        if Stats.shared.bite == 4{
        burger.texture = nil
        }else {
        burger.texture = burgerImages[Stats.shared.bite]
        }
        previousBite = Stats.shared.bite
        guard Stats.shared.bite == 4 else {return}
        Stats.shared.score += 1
        Stats.shared.bite = 0
        if Stats.shared.score >= Stats.shared.bestScore {
            Stats.shared.bestScore = Stats.shared.score
            Stats.shared.newHighScore = true
        }
        guard Stats.shared.gcEnabled == true && Stats.shared.bestScore < 50 && Stats.shared.newHighScore == true else {return}
            let a50 = GKAchievement(identifier: "50_burgers")
            a50.percentComplete = Double(Stats.shared.score) * 2
            a50.showsCompletionBanner = true
            GKAchievement.report([a50], withCompletionHandler: nil)
        guard Stats.shared.bestScore < 40 else {return}
            let a40 = GKAchievement(identifier: "40_burgers")
            a40.percentComplete = Double(Stats.shared.score) * 2.5
            a40.showsCompletionBanner = true
            GKAchievement.report([a40], withCompletionHandler: nil)
        guard Stats.shared.bestScore <= 30 else {return}
            let a30 = GKAchievement(identifier: "30_burgers")
            a30.percentComplete = Double(Stats.shared.score) * 3.34
            a30.showsCompletionBanner = true
            GKAchievement.report([a30], withCompletionHandler: nil)
        guard Stats.shared.bestScore <= 20 else {return}
            let a20 = GKAchievement(identifier: "20_burgers")
            a20.percentComplete = Double(Stats.shared.score) * 5
            a20.showsCompletionBanner = true
            GKAchievement.report([a20], withCompletionHandler: nil)
    }

    
}

