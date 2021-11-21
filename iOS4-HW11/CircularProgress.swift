//
//  CircularProgress.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 20.11.2021.
//

import UIKit

class CircularProgress: UIView {
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var tracklayer = CAShapeLayer()
    fileprivate var circle = CAShapeLayer()
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    var progressColor: UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = UIColor.white {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
        }
    }
    
    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: CGFloat(100), startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor.cgColor
        tracklayer.lineWidth = 3.0;
        tracklayer.strokeEnd = 1.0
//        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 3.0
        //        layer.addSublayer(progressLayer)
        
        let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: (frame.size.height / 2.0) - 100), radius: CGFloat(10), startAngle: CGFloat(-0.5 * Double.pi),
                                           endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        circle.path = smallCirclePath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = progressColor.cgColor
        circle.lineWidth = 3.0;
        circle.strokeEnd = 1.0
        layer.addSublayer(circle)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: CGFloat(100), startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        //        progressLayer.add(animation, forKey: "animateCircle")
        
        //
        
        let orbit = CAKeyframeAnimation(keyPath: "position")
//        var affineTransform = CGAffineTransform(rotationAngle: 0.0)
//        affineTransform = affineTransform.rotated(by: CGFloat(Double.pi))
        
        orbit.path = circlePath.cgPath
        orbit.duration = duration
        orbit.isAdditive = true
        orbit.repeatCount = 1
        

        orbit.calculationMode = CAAnimationCalculationMode.cubic
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
//        orbit.accessibilityActivationPoint = CGPoint(x: CGFloat(-0.5 * Double.pi), y: CGFloat(-0.5 * Double.pi))
        
        
        circle.add(orbit, forKey: "orbit")
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 1.0;
        progressLayer.strokeEnd = 1.0
                layer.addSublayer(progressLayer)
    }
    
}
