//
//  MenuViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit
import ARKit
import GameKit

class MenuViewController: UIViewController,GKGameCenterControllerDelegate {
    
    static let shared = MenuViewController()
    @IBOutlet weak var bestScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        if let unarchive =  NSKeyedUnarchiver.unarchiveObject(withFile: Save.archiveURL.path) as? Save{
            Stats.shared.bestScore = unarchive.bestScore
            Stats.shared.adTurn = unarchive.adTurn
            Stats.shared.removeAds = unarchive.removeAds
            Stats.shared.cameraView = unarchive.cameraView
            Stats.shared.soundEffects = unarchive.soundEffects
        }
        bestScore.text = "Best: \(Stats.shared.bestScore)"
    }
    override func viewDidAppear(_ animated: Bool) {
        if !ARFaceTrackingConfiguration.isSupported {
            let alert = UIAlertController(title: "Unsupported Device", message: "Speed Eating Requires the True Depth Camera on the iPhone X", preferredStyle: .alert)
            self.present(alert,animated: true,completion: nil)
        }
    }
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
             Stats.shared.gcEnabled = true
            } else {
            Stats.shared.gcEnabled = false
            }
        }
    }
    
}
