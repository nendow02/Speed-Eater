//
//  Save.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/7/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import Foundation

class Save {
        
    func saveData(bestScore:Int,adTurn:Int,removeAds:Bool,cameraView:Bool,soundEffects:Bool) {
        UserDefaults.standard.set(bestScore, forKey: "bestScore")
        UserDefaults.standard.set(adTurn, forKey: "adTurn")
        UserDefaults.standard.set(removeAds, forKey: "removeAds")
        UserDefaults.standard.set(cameraView, forKey: "cameraView")
        UserDefaults.standard.set(soundEffects, forKey: "soundEffects")
    }
    
    func getData() {
        Stats.shared.bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        Stats.shared.adTurn = UserDefaults.standard.integer(forKey: "adTurn")
        Stats.shared.removeAds = UserDefaults.standard.bool(forKey: "removeAds")
        Stats.shared.cameraView = UserDefaults.standard.bool(forKey: "cameraView")
        Stats.shared.soundEffects = UserDefaults.standard.bool(forKey: "soundEffects")
    }
    
}
