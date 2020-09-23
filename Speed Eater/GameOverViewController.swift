//
//  GameOverViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit
import GameKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    @IBOutlet var removeAds: UILabel!
    
    let sdk = VungleSDK.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Stats.shared.score >= 40 {
            Stats.shared.removeAds = true
            removeAds.text = "Congrats! Ads have been removed for free."
        }
        else if Stats.shared.removeAds == true {
            removeAds.text = ""
        }
        else if Stats.shared.adTurn == 2{
            Stats.shared.adTurn = 0
            try! sdk.playAd(self, options: nil, placementID: "DEFAULT-0356197")
        }else {
            Stats.shared.adTurn += 1
        }
        Save().saveData(bestScore: Stats.shared.bestScore, adTurn:Stats.shared.adTurn, removeAds:Stats.shared.removeAds, cameraView:Stats.shared.cameraView, soundEffects:Stats.shared.soundEffects)
        score.text = String(Stats.shared.score)
        if Stats.shared.newHighScore{
            bestScore.text = "New Highscore!"
            guard Stats.shared.gcEnabled == true else {return}
            let bestScoreInt = GKScore(leaderboardIdentifier:"leaderboard")
            bestScoreInt.value = Int64(Stats.shared.bestScore)
            GKScore.report([bestScoreInt]) { (error) in
                if error != nil {
                    return
                }
            }
        }else{
            bestScore.text = "Best:\(Stats.shared.bestScore)"
        }
     
    }

}
