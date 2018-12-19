//
//  WaterWave.swift
//  Charging Animation
//
//  Created by Adeyinka Adediji on 28/02/2017.
//  Copyright © 2017 Adeyinka Adediji. All rights reserved.
//

import UIKit

class WaterWave: UIView {
    lazy var waveDisplaylink = CADisplayLink()
    lazy var waveLayer = CAShapeLayer()
    fileprivate var waveWidth: CGFloat!
    fileprivate var waveHeight: CGFloat!
    private var waveAmplitude: CGFloat = 8
    fileprivate var waveSpeed = CGFloat(0.05)
    private var offsetX: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        waveWidth = 2 * CGFloat(Double.pi) / bounds.size.width
        waveHeight = bounds.size.height * 0.5
        waveLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(waveLayer)
        waveDisplaylink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplaylink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    deinit {
        waveDisplaylink.invalidate()
    }
    
    @objc fileprivate func getCurrentWave() {
        offsetX += waveSpeed
        setCurrentStatusWavePath()
    }
    
    fileprivate func setCurrentStatusWavePath() {
        let path = CGMutablePath()
        var y = bounds.size.width / 2
        path.move(to: CGPoint(x: 0, y: y))
        for i in 0...Int(bounds.size.width) {
            y = waveAmplitude * sin(waveWidth * CGFloat(i) + offsetX) + waveHeight
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        path.closeSubpath()
        waveLayer.path = path
    }
    
    func setWavePercentage(_ percentage: CGFloat) {
        waveHeight = bounds.size.height * (1 - (percentage / 100))
    }
}
