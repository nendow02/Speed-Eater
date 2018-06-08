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
    
    init(bestScore:Int,adTurn:Int){
        self.bestScore = bestScore
        self.adTurn = adTurn
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bestScore, forKey: "bestScore")
        aCoder.encode(adTurn, forKey: "adTurn")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let bestScore = aDecoder.decodeInteger(forKey: "bestScore")
        let adTurn = aDecoder.decodeInteger(forKey: "adTurn")
        self.init(bestScore:bestScore,adTurn:adTurn)
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("speedEating")

    
}
