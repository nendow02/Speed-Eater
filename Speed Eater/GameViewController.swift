//
//  GameViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import ARKit


class GameViewController: UIViewController,ARSKViewDelegate,ARSessionDelegate {

    @IBOutlet var sceneView: ARSKView!
    var open = false
    override func viewDidLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        Stats.shared.newHighScore = false
        Stats.shared.score = 0
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.session.delegate = self
        if let scene = GKScene(fileNamed: "GameScene") {
            
            if let sceneNode = scene.rootNode as! GameScene? {

                sceneNode.scaleMode = .aspectFill
                sceneNode.viewController = self
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
    }

    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
        let faceAnchor = anchor as! ARFaceAnchor
        if faceAnchor.blendShapes[.jawOpen]!.doubleValue > 0.5 {
            open = true
        }else {
            guard open == true && Stats.shared.gameStarted == true else {return}
            open = false
            Stats.shared.bite += 1
        }
            
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
