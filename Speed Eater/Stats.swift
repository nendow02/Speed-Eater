//
//  stats.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/6/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import Foundation

class Stats {
   static let shared = Stats()
    var bestScore = 0
    var score = 0
    var bite = 0
    var newHighScore = false
    var gameStarted = false
    var adTurn = 0
    var removeAds = false
    var gcEnabled = false
    var cameraView = false
    var soundEffects = true
}
