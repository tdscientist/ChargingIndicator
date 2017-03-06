//
//  WaterWave.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 28/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import Foundation
import UIKit


class WaterWave : UIView{
    
    let waveColor = UIColor.white
    var waveBackgroundColor = Utils().hexStringToUIColorTranslucent(hex: "#ffffff", alphaValue: 0.3)
    var waveProgress = CGFloat(0)
    var a = Double(1.5)
    var b = Double(0)
    var jia = false
    var waveWidth = Int()
    let utils = Utils()
    
    let timeInterval = Double(0.02)
    var timer = Timer()
    
    let percentageIndicatorHeight = CGFloat(125)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = waveBackgroundColor
        waveWidth = Int(utils.getDeviceScreenWidth())
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(animateWave), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // animate the waterwave
    func animateWave () {
        
        if (jia) {
            a += 0.01
        }else{
            a -= 0.01
        }
        
        if (a<=1) {
            jia = true
        }
        
        if (a>=1.5) {
            jia = false
        }
        
        b += 0.1
        
        setNeedsDisplay()
    }
    
    // draw the waterwave
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let path = CGMutablePath()
        
        context!.setLineWidth(1);
        context!.setFillColor(waveColor.cgColor)
        
        var y = waveProgress
        path.move(to: CGPoint(x: 0, y: waveProgress))
        
        for x in 0 ..< waveWidth {
            y = CGFloat(a * sin(Double(x)/Double(180)*M_PI + 4*b/M_PI ) * 5 + Double(waveProgress))
            path.addLine(to: CGPoint(x: x, y: Int(y)))
        }
        
        path.addLine(to: CGPoint(x: CGFloat(waveWidth), y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: waveProgress))
        
        context!.addPath(path);
        context?.fillPath();
        context!.drawPath(using: .stroke)
    }
    
    // change the progress(height) of the waterwave
    func adjustWaveProgress(_ percentage: CGFloat, yCoordinateViewEnd: CGFloat) {
        let progress = (percentage/100) * percentageIndicatorHeight
        waveProgress = yCoordinateViewEnd - progress
        resetParams()
    }
    
    // reset the waterwave view to effect any update done to it
    func resetParams () {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(animateWave), userInfo: nil, repeats: true)
    }
    
}
