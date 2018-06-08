//
//  MenuViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/4/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit
import ARKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var bestScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unarchive =  NSKeyedUnarchiver.unarchiveObject(withFile: Save.archiveURL.path) as? Save{
        Stats.shared.bestScore = unarchive.bestScore
        Stats.shared.adTurn = unarchive.adTurn
        }
        bestScore.text = "Best: \(Stats.shared.bestScore)"
    }
    override func viewDidAppear(_ animated: Bool) {
        if !ARFaceTrackingConfiguration.isSupported {
            let alert = UIAlertController(title: "Unsupported Device", message: "Speed Eating Requires the True Depth Camera on the iPhone X", preferredStyle: .alert)
            self.present(alert,animated: true,completion: nil)
        }
    }


}
