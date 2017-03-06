//
//  ChargerController.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 18/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import UIKit
import Foundation

class ChargerController: UIViewController {
    
    
    let utils = Utils()
    
    let backdrop = UIView()
    let backdropLayer = CAGradientLayer()
    
    let chargingText = UILabel()
    let chargingTextWidth = CGFloat(100)
    let chargingTextHeight = CGFloat(40)
    
    let estimatedText = UILabel()
    let estimatedTextWidth = CGFloat(200)
    let estimatedTextHeight = CGFloat(40)
    
    let chargingFigure = UILabel()
    let chargingFigureWidth = CGFloat(200)
    let chargingFigureHeight = CGFloat(160)
    
    let percentage = UILabel()
    let percentageWidth = CGFloat(70)
    let percentageHeight = CGFloat(70)
    
    let estimatedFigure = UILabel()
    let estimatedFigureWidth = CGFloat(100)
    let estimatedFigureHeight = CGFloat(60)
    
    let slideToSpeed = UIView()
    let slideToSpeedWidth = CGFloat(220)
    let slideToSpeedHeight = CGFloat(45)
    
    let slideText = UILabel()
    let slideTextWidth = CGFloat(150)
    var slideTextString = NSMutableAttributedString(string: Const.slideToSpeedUp)
    
    var lengthOfTextToColor = 0;
    let flashTextCharacterCount = 3
    
    var flashTimer = Timer()
    let flashTimerInterval = Double(0.01)
    let flashDelay = Double(2)
    
    let waterWave = WaterWave()
    
    // let's get started
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(ChargerController.batteryStateDidChange(_:)), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChargerController.batteryLevelDidChange(_:)), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        initLayouts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // return the current battery level of the device.
    // pls, note that iOS simulators always return -1 for battery level.
    // use a real device to get real figures.
    var batteryLevelPercent: Int {
        return UIDevice.current.batteryLevel == -1 ? 89 : Int(UIDevice.current.batteryLevel * 100)
    }
    
    // callback to monitor change in battery state
    func batteryStateDidChange(_ o: AnyObject){
        //will be used later
    }
    
    // callback to monitor change in battery level
    func batteryLevelDidChange (_ o: AnyObject){
        setChargingProgress(percentageProgress:batteryLevelPercent)
    }
    
    // create all views needed
    private func initLayouts(){
        
        let screenWidth = utils.getDeviceScreenWidth()
        let screenHeight = utils.getDeviceScreenHeight()
        
        backdrop.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        backdropLayer.frame = backdrop.frame
        backdropLayer.colors = [utils.hexStringToUIColor(hex: Colors.DARK_TURQUOISE).cgColor,utils.hexStringToUIColor(hex: Colors.BLUE_VIOLET).cgColor]
        backdropLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        backdropLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        backdrop.layer.addSublayer(backdropLayer)
        self.view.addSubview(backdrop)
        
        
        chargingText.frame = CGRect(x: (screenWidth - chargingTextWidth)/2, y: 65, width: chargingTextWidth, height: chargingTextHeight)
        chargingText.text = Const.charging
        chargingText.textAlignment = .center
        chargingText.textColor = utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.7)
        chargingText.font = .systemFont(ofSize: 19)
        self.view.addSubview(chargingText)
        
        
        chargingFigure.frame = CGRect(x: (screenWidth - chargingFigureWidth)/2, y: utils.getViewEndY(viewToMeasure: chargingText) + 67, width: chargingFigureWidth, height: chargingFigureHeight)
        chargingFigure.textAlignment = .center
        chargingFigure.textColor = .white
        chargingFigure.font = UIFont(name: "OldRepublic", size: 250)
        self.view.addSubview(chargingFigure)
        
        
        estimatedText.frame = CGRect(x: (screenWidth - estimatedTextWidth)/2, y: utils.getViewEndY(viewToMeasure: chargingFigure) + 30, width: estimatedTextWidth, height: estimatedTextHeight)
        estimatedText.text = Const.estimated
        estimatedText.textAlignment = .center
        estimatedText.textColor = utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.7)
        estimatedText.font = .systemFont(ofSize: 18)
        self.view.addSubview(estimatedText)
        
        
        estimatedFigure.frame = CGRect(x: (screenWidth - estimatedFigureWidth)/2, y: utils.getViewEndY(viewToMeasure: estimatedText) - 20 , width: estimatedFigureWidth, height: estimatedFigureHeight)
        estimatedFigure.text = "08:29"
        estimatedFigure.textAlignment = .center
        estimatedFigure.textColor = .white
        estimatedFigure.font = UIFont(name: "OldRepublic", size: 44)
        self.view.addSubview(estimatedFigure)
        
        
        slideToSpeed.frame = CGRect(x: (screenWidth - slideToSpeedWidth)/2, y: utils.getViewEndY(viewToMeasure: estimatedFigure) + 20, width: slideToSpeedWidth, height: slideToSpeedHeight)
        slideToSpeed.backgroundColor = utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.3)
        slideToSpeed.layer.cornerRadius = 23
        
        
        let slideRingWidth = slideToSpeedHeight - 10
        let slideRing = UIView(frame: CGRect(x: (slideToSpeedHeight - slideRingWidth )/2, y: (slideToSpeedHeight - slideRingWidth )/2, width: slideRingWidth, height: slideRingWidth))
        slideRing.layer.borderWidth = 2
        slideRing.layer.borderColor = utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.3).cgColor
        slideRing.layer.cornerRadius = slideRingWidth/2
        slideToSpeed.addSubview(slideRing)
        
        
        let slideRingImageWidth = slideRingWidth - 6
        let slideRingImage = UIImageView(image: UIImage(named: "ic_chevron_right.png"))
        utils.tintImage(imageView: slideRingImage, color: "#ffffff", alphaValue: 0.5)
        slideRingImage.frame = CGRect(x: (slideToSpeedHeight - slideRingImageWidth)/2 , y: (slideToSpeedHeight - slideRingImageWidth)/2, width: slideRingImageWidth, height: slideRingImageWidth)
        slideToSpeed.addSubview(slideRingImage)
        
        
        slideText.frame = CGRect(x: utils.getViewEndX(viewToMeasure: slideRingImage) + 15, y: (slideToSpeedHeight - slideRingImageWidth)/2, width: slideTextWidth, height: slideRingImageWidth)
        slideText.font = slideTextFont ()
        slideText.textColor = slideTextAlphaWhiteColor()
        slideText.textAlignment = .left
        slideText.text = Const.slideToSpeedUp
        slideToSpeed.addSubview(slideText)
        self.view.addSubview(slideToSpeed)
        
        
        waterWave.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        waterWave.mask = chargingFigure
        self.view.addSubview(waterWave)
        
        
        percentage.frame = CGRect(x: utils.getViewEndX(viewToMeasure: chargingFigure) - 40, y: utils.getViewEndY(viewToMeasure: chargingFigure) - percentageHeight + 6, width: percentageWidth, height: percentageHeight)
        percentage.text = Const.percentage
        percentage.textAlignment = .center
        percentage.textColor = utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.3)
        percentage.font = UIFont(name: "TitilliumWeb-Light", size: 60)
        self.view.addSubview(percentage)
        
        
        initializeFlashTimer()
        
        
        self.setChargingProgress(percentageProgress:batteryLevelPercent)
    }
    
    // adjust the waterwave progress(height)
    func setChargingProgress(percentageProgress: Int){
        chargingFigure.text = String(describing: percentageProgress)
        self.waterWave.adjustWaveProgress(CGFloat(percentageProgress), yCoordinateViewEnd: utils.getViewEndY(viewToMeasure: chargingFigure))
    }
    
    // create animation for the "slide to speed up" text
    func flashSlideText () {
        if lengthOfTextToColor <= slideTextString.length - flashTextCharacterCount {
            lengthOfTextToColor += 1
            
            let range =  NSMakeRange(lengthOfTextToColor - 1, flashTextCharacterCount);
            let textAttribute =  [NSFontAttributeName : slideTextFont(), NSForegroundColorAttributeName : slideTextWhiteColor()]
            slideTextString.addAttributes(textAttribute, range: range)
            slideText.attributedText = slideTextString
            
            let cleanUpRange =  NSMakeRange(0, lengthOfTextToColor - 1);
            let cleanUpTextAttribute =  [NSFontAttributeName : slideTextFont(), NSForegroundColorAttributeName : slideTextAlphaWhiteColor()]
            slideTextString.addAttributes(cleanUpTextAttribute, range: cleanUpRange)
            
        }else if lengthOfTextToColor == slideTextString.length - 2 {
            
            let fullRange =  NSMakeRange(0, slideTextString.length);
            let fullTextAttribute =  [NSFontAttributeName : slideTextFont(), NSForegroundColorAttributeName : slideTextAlphaWhiteColor()]
            slideTextString.addAttributes(fullTextAttribute, range: fullRange)
            
            slideText.text = Const.slideToSpeedUp
            flashTimer.invalidate()
            utils.delay(flashDelay){
                self.lengthOfTextToColor = 0
                self.initializeFlashTimer()
            }
        }
    }
    
    //return UIFont of size 19 for the slide text animation
    private func slideTextFont () -> UIFont {
        return UIFont.systemFont(ofSize: 19)
    }
    
    // return full white UIColor for the slide text animation
    private func slideTextWhiteColor () -> UIColor {
        return utils.hexStringToUIColor(hex: "ffffff")
    }
    
    // return 50% transparent white UIColor for the slide text animation
    private func slideTextAlphaWhiteColor () -> UIColor {
        return  utils.hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.5)
    }
    
    // initialize timer to animate the slide text
    private func initializeFlashTimer(){
        flashTimer =   Timer.scheduledTimer(timeInterval: flashTimerInterval, target: self, selector: #selector(flashSlideText), userInfo: nil, repeats: true)
    }
    
    
}

