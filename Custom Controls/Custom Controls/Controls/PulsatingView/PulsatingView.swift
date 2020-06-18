//
//  PulsatingView.swift
//  Custom Controls
//
//  Created by Granit Gjevukaj on 6/18/20.
//  Copyright © 2020 Hafen Tech. All rights reserved.
//

import UIKit

class PulsatingView: UIView {
    
    var controlWidth = CGFloat()
    var controlHeight = CGFloat()
    var lineWidth = Float()
    var radius = Float()
    var largeFontSize = Float()
    
    var arc1Angle: Double = 0
    var arc2Angle: Double = Double.pi / 2
    var arc3Angle: Double = Double.pi + Double.pi / 4

    var arc1OuterAngle: Double = 0
    var arc2OuterAngle: Double = Double.pi / 2
    var arc3OuterAngle: Double = Double.pi + Double.pi / 4
    
    var baseSpeed = 0.02
    var secondBaseSpeed = 0.01
    
    var vibrationFactor:Float = 0
    var vibrationProgress:Float  = 0
    
    var timerInitialised = false

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let clrFilled = UIColor.black
        let crlSecondFilled = UIColor.yellow
        let crlThirdFilled = UIColor.orange
        
        if !timerInitialised {
            _ = Timer.scheduledTimer(timeInterval: 1.0 / 60, target: self, selector: #selector(changeAngleForMovement), userInfo: nil, repeats: true)
            self.timerInitialised = true
        }
        
        self.controlHeight = rect.size.height
        self.controlWidth = rect.size.width
        
        let innerCircleRadius = rect.size.width / 1.65 + CGFloat(self.vibrationFactor) * rect.size.width / 50
        let secondInnerCircleRadius = rect.size.width / 1.85 + CGFloat(self.vibrationFactor) * rect.size.width / 30
        let thirdInnerCircleRadius = rect.size.width / 2.05 + CGFloat(self.vibrationFactor) * rect.size.width / 30
        let firstArcRadius = rect.size.width / 2.4
        let secondArcRadius = rect.size.width / 2.18
        
        let cContext = UIGraphicsGetCurrentContext()!
        
        // Third Inner Circle
        cContext.setStrokeColor(crlThirdFilled.cgColor)
        cContext.setLineWidth(self.controlWidth / 35)
        
        cContext.strokeEllipse(in: CGRect(x: self.controlWidth / 2 - thirdInnerCircleRadius / 2,
                                          y: controlHeight / 2 - thirdInnerCircleRadius / 2,
                                          width: thirdInnerCircleRadius,
                                          height: thirdInnerCircleRadius))
        
        // Second Inner Circle
        cContext.setStrokeColor(crlSecondFilled.cgColor)
        cContext.setLineWidth(self.controlWidth / 30)
        
        cContext.strokeEllipse(in: CGRect(x: self.controlWidth / 2 - secondInnerCircleRadius / 2,
                                          y: controlHeight / 2 - secondInnerCircleRadius / 2,
                                          width: secondInnerCircleRadius,
                                          height: secondInnerCircleRadius))
        
        // Draw Inner Circle
        cContext.setStrokeColor(clrFilled.cgColor)
        cContext.setLineWidth(self.controlWidth / 15)
        
        cContext.strokeEllipse(in: CGRect(x: self.controlWidth / 2 - innerCircleRadius / 2,
                                          y: controlHeight / 2 - innerCircleRadius / 2,
                                          width: innerCircleRadius,
                                          height: innerCircleRadius))
        
        cContext.setLineWidth(5.0)
        cContext.setStrokeColor(clrFilled.cgColor)
        cContext.setLineCap(.round)

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: firstArcRadius, startAngle: CGFloat(arc1Angle), endAngle: CGFloat(arc1Angle + Double.pi / 4), clockwise: false)
        cContext.strokePath()

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: firstArcRadius, startAngle: CGFloat(arc2Angle), endAngle: CGFloat(arc2Angle + Double.pi / 4), clockwise: false)
        cContext.strokePath()

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: firstArcRadius, startAngle: CGFloat(arc3Angle), endAngle: CGFloat(arc3Angle + Double.pi / 4), clockwise: false)
        cContext.strokePath()

        // Draw Outmost Circles

        cContext.setLineWidth(5.0)
        cContext.setStrokeColor(clrFilled.cgColor)
        cContext.setLineCap(.round)

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: secondArcRadius, startAngle: CGFloat(arc1OuterAngle), endAngle: CGFloat(arc1OuterAngle + Double.pi / 4), clockwise: false)
        cContext.strokePath()

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: secondArcRadius, startAngle: CGFloat(arc2OuterAngle), endAngle: CGFloat(arc2OuterAngle + Double.pi / 4), clockwise: false)
        cContext.strokePath()

        cContext.beginPath()
        cContext.addArc(center: CGPoint(x: controlWidth / 2, y: controlHeight / 2), radius: secondArcRadius, startAngle: CGFloat(arc3OuterAngle), endAngle: CGFloat(arc3OuterAngle + Double.pi / 4), clockwise: false)
        cContext.strokePath()
    }
    
    @objc func changeAngleForMovement() {
        arc1Angle += baseSpeed
        arc2Angle += baseSpeed * 3
        arc3Angle -= baseSpeed * 2
        
        arc1OuterAngle += secondBaseSpeed
        arc2OuterAngle += secondBaseSpeed * 3
        arc3OuterAngle += secondBaseSpeed * 2
        
        vibrationProgress += Float(0.2)
        vibrationFactor = sin(vibrationProgress) - cos(vibrationProgress) * cos(vibrationProgress)
        
        setNeedsDisplay()
    }
}
