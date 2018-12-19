//
//  ChargerController.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 18/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import UIKit

class ChargerController: UIViewController {
    var waterWave: WaterWave!
    @IBOutlet var chargingFigure: UILabel!
    @IBOutlet var chargingLabel: UILabel!
    @IBOutlet var estimateFigure: UILabel!
    @IBOutlet var estimateLabel: UILabel!
    @IBOutlet var slideText: UILabel!
    @IBOutlet var slideBar: UIView!
    @IBOutlet var waterWaveMother: UIView!
    @IBOutlet var backgroundMarginTop: NSLayoutConstraint!
    @IBOutlet var backgroundMarginBottom: NSLayoutConstraint!
    @IBOutlet var percentageLabelMarginLeft: NSLayoutConstraint!
    var flashTimer = Timer()
    let flashTimerInterval = Double(0.01)
    let flashDelay = Double(2)
    var lengthOfTextToColor = 0
    let flashTextCharacterCount = 3
    let slide_to_speed_up = "slide to speed up"
    lazy var slideTextString = NSMutableAttributedString(string: slide_to_speed_up)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundMarginTop.constant = -UIApplication.shared.statusBarFrame.height
        backgroundMarginBottom.constant = -UIApplication.shared.statusBarFrame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange(_:)), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange(_:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        waterWave = WaterWave(frame: waterWaveMother.bounds)
        waterWaveMother.addSubview(waterWave)
        waterWaveMother.mask = chargingFigure
        setChargingProgress(percentageProgress: batteryLevelPercent)
        slideBar.layer.cornerRadius = slideBar.frame.height / 2
        slideText.textColor = slideTextAlphaWhiteColor()
        initializeFlashTimer()
    }
    
    // return the current battery level of the device.
    // pls, note that iOS simulators always return -1 for battery level.
    // use a real device to get real figures.
    var batteryLevelPercent: Int {
        return UIDevice.current.batteryLevel == -1 ? 89 : Int(UIDevice.current.batteryLevel * 100)
    }
    
    // callback to monitor change in battery state
    @objc func batteryStateDidChange(_ a: AnyObject) {
        // will be used later
    }
    
    // callback to monitor change in battery level
    @objc func batteryLevelDidChange(_ a: AnyObject) {
        setChargingProgress(percentageProgress: batteryLevelPercent)
    }
    
    // adjust the waterwave progress(height)
    func setChargingProgress(percentageProgress: Int) {
        percentageLabelMarginLeft.constant = percentageProgress == 100 ? 0 : -25
        chargingLabel.text = percentageProgress >= 100 ? "Charged" : "Charging ..."
        estimateFigure.isHidden = percentageProgress >= 100
        estimateLabel.isHidden = percentageProgress >= 100
        slideBar.isHidden = percentageProgress >= 100
        chargingFigure.text = String(describing: percentageProgress)
        waterWave.setWavePercentage(CGFloat(percentageProgress))
    }
    
    // create animation for the "slide to speed up" text
    @objc fileprivate func flashSlideText() {
        if lengthOfTextToColor <= slideTextString.length - flashTextCharacterCount {
            lengthOfTextToColor += 1
            
            let range = NSMakeRange(lengthOfTextToColor - 1, flashTextCharacterCount)
            let textAttribute = [NSAttributedString.Key.font: slideTextFont(), NSAttributedString.Key.foregroundColor: UIColor.white]
            slideTextString.addAttributes(textAttribute, range: range)
            
            let cleanUpRange = NSMakeRange(0, lengthOfTextToColor - 1)
            let cleanUpTextAttribute = [NSAttributedString.Key.font: slideTextFont(), NSAttributedString.Key.foregroundColor: slideTextAlphaWhiteColor()]
            slideTextString.addAttributes(cleanUpTextAttribute, range: cleanUpRange)
            
        } else if lengthOfTextToColor == slideTextString.length - 2 {
            let range = NSMakeRange(0, slideTextString.length)
            let textAttribute = [NSAttributedString.Key.font: slideTextFont(), NSAttributedString.Key.foregroundColor: slideTextAlphaWhiteColor()]
            slideTextString.addAttributes(textAttribute, range: range)
            
            flashTimer.invalidate()
            Utils().delay(flashDelay) {
                self.lengthOfTextToColor = 0
                self.initializeFlashTimer()
            }
        }
        slideText.attributedText = slideTextString
    }
    
    // initialize timer to animate the slide text
    fileprivate func initializeFlashTimer() {
        flashTimer = Timer.scheduledTimer(timeInterval: flashTimerInterval, target: self, selector: #selector(flashSlideText), userInfo: nil, repeats: true)
    }
    
    fileprivate func slideTextFont() -> UIFont {
        return slideText.font
    }
    
    // 50% transparent white UIColor for the slide text animation
    fileprivate func slideTextAlphaWhiteColor() -> UIColor {
        return UIColor("#ffffff", alpha: 0.5)
    }
}
