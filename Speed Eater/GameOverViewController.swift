//
//  GameOverViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    
    let sdk = VungleSDK.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Stats.shared.adTurn == 2{
            Stats.shared.adTurn = 0
            try! sdk.playAd(self, options: nil, placementID: "DEFAULT-0356197")
        }else {
            Stats.shared.adTurn += 1
        }
        NSKeyedArchiver.archiveRootObject(Save(bestScore: Stats.shared.bestScore,adTurn:Stats.shared.adTurn), toFile: Save.archiveURL.path)
        
        score.text = String(Stats.shared.score)
        if Stats.shared.newHighScore{
            bestScore.text = "New Highscore!"
        }else{
        bestScore.text = String(Stats.shared.bestScore)
        }
     
    }

}
