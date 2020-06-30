//
//  SettingsViewController.swift
//  Speed Eater
//
//  Created by Nathan Endow on 6/8/18.
//  Copyright © 2018 Greg Endow. All rights reserved.
//

import UIKit
import StoreKit
import GameKit

class SettingsViewController: UIViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver {
    
    @IBOutlet var removeAdsOutlet: UIButton!
    @IBOutlet var cameraViewSwitchOutlet: UISwitch!
    @IBOutlet var soundEffectsSwitchOutlet: UISwitch!
    
    @IBAction func privacyPolicy(_ sender: UIButton) {
        let link = URL(string: "https://sites.google.com/site/gregendowgames/privacy-policy")
        UIApplication.shared.open(link!, options:convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    @IBAction func cameraViewSwitch(_ sender: UISwitch) {
        Stats.shared.cameraView = !Stats.shared.cameraView
        NSKeyedArchiver.archiveRootObject(Save(bestScore: Stats.shared.bestScore,adTurn:Stats.shared.adTurn,removeAds:Stats.shared.removeAds,cameraView:Stats.shared.cameraView,soundEffects:Stats.shared.soundEffects), toFile: Save.archiveURL.path)
    }
    @IBAction func soundEffectsSwitch(_ sender: UISwitch) {
        Stats.shared.soundEffects = !Stats.shared.soundEffects
        NSKeyedArchiver.archiveRootObject(Save(bestScore: Stats.shared.bestScore,adTurn:Stats.shared.adTurn,removeAds:Stats.shared.removeAds,cameraView:Stats.shared.cameraView,soundEffects:Stats.shared.soundEffects), toFile: Save.archiveURL.path)
    }
    @IBAction func removeAds(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments(){
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(SKPayment(product: product))
            removeAdsOutlet.isEnabled = false
        }
    }
    @IBAction func restore(_ sender: UIButton) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    @IBAction func leaderboard(_ sender: UIButton) {
        guard Stats.shared.gcEnabled == true else {return}
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = MenuViewController.shared
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = "leaderboard"
        present(gcVC, animated: true, completion: nil)
    }
    @IBAction func achievements(_ sender: UIButton) {
        guard Stats.shared.gcEnabled == true else {return}
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = MenuViewController.shared
        gcVC.viewState = .achievements
        present(gcVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraViewSwitchOutlet.isOn = Stats.shared.cameraView
        soundEffectsSwitchOutlet.isOn = Stats.shared.soundEffects
        let productID = NSSet(object: "removeAds")
        let productsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()

    }
    var product = SKProduct()
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard response.products.count > 0 else {return}
        product = response.products[0]
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    Stats.shared.removeAds = true
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    Stats.shared.removeAds = true
                default: break
                }
            }
        }
        NSKeyedArchiver.archiveRootObject(Save(bestScore: Stats.shared.bestScore,adTurn:Stats.shared.adTurn,removeAds:Stats.shared.removeAds,cameraView:Stats.shared.cameraView,soundEffects:Stats.shared.soundEffects), toFile: Save.archiveURL.path)
        removeAdsOutlet.isEnabled = true
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
