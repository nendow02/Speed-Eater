//
//  Save.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/7/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import Foundation

class Save: NSObject,NSCoding{
    
    var bestScore: Int
    var adTurn: Int
    var removeAds: Bool
    var cameraView: Bool
    var soundEffects: Bool
    
    init(bestScore:Int,adTurn:Int,removeAds:Bool,cameraView:Bool,soundEffects:Bool){
        self.bestScore = bestScore
        self.adTurn = adTurn
        self.removeAds = removeAds
        self.cameraView = cameraView
        self.soundEffects = soundEffects
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bestScore, forKey: "bestScore")
        aCoder.encode(adTurn, forKey: "adTurn")
        aCoder.encode(removeAds, forKey: "removeAds")
        aCoder.encode(cameraView, forKey: "cameraView")
        aCoder.encode(soundEffects, forKey: "soundEffects")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let bestScore = aDecoder.decodeInteger(forKey: "bestScore")
        let adTurn = aDecoder.decodeInteger(forKey: "adTurn")
        let removeAds = aDecoder.decodeBool(forKey: "removeAds")
        let cameraView = aDecoder.decodeBool(forKey: "cameraView")
        let soundEffects = aDecoder.decodeBool(forKey: "soundEffects")
        self.init(bestScore:bestScore,adTurn:adTurn,removeAds:removeAds,cameraView:cameraView,soundEffects:soundEffects)
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("speedEating")

    
}
