//
//  CircularProgress.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 20.11.2021.
//

import UIKit

class CircularProgress: UIView {
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var progressCircle = CAShapeLayer()
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
    
    var trackColor: UIColor = UIColor.brown {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
            progressCircle.strokeColor = trackColor.cgColor
        }
    }
    
    var progressColor: UIColor = UIColor.green {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    fileprivate func pauseLayer(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    fileprivate func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    fileprivate func removeLayer(layer: CALayer) {
        layer.removeAllAnimations()
        progressLayer.strokeEnd = 0
    }
    
    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                         y: frame.size.height / 2.0),
                                      radius: CGFloat(100),
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 3.0;
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.brown.cgColor
        progressLayer.lineWidth = 3.0;
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        
        let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                              y: (frame.size.height / 2.0) - 100),
                                           radius: CGFloat(10),
                                           startAngle: CGFloat(-0.5 * Double.pi),
                                           endAngle: CGFloat(1.5 * Double.pi),
                                           clockwise: true)
        
        progressCircle.path = smallCirclePath.cgPath
        progressCircle.fillColor = UIColor.white.cgColor
        progressCircle.strokeColor = trackColor.cgColor
        progressCircle.lineWidth = 3.0;
        progressCircle.strokeEnd = 1.0
        layer.addSublayer(progressCircle)
    }
    
    func setProgressWithAnimation(duration: TimeInterval) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                         y: frame.size.height / 2.0),
                                      radius: CGFloat(37),
                                      startAngle: CGFloat(-0.66 * Double.pi),
                                      endAngle: CGFloat(1.34 * Double.pi),
                                      clockwise: true)
        
        let orbit = CAKeyframeAnimation(keyPath: "position")
        var affineTransform = CGAffineTransform(rotationAngle: 0.0)
        affineTransform = affineTransform.rotated(by: CGFloat(Double.pi))
        let initialPoint = CGPoint(x: 0, y: 0)
        circlePath.move(to: initialPoint)
        orbit.path = circlePath.cgPath
        orbit.duration = duration
        orbit.isAdditive = true
        orbit.repeatCount = 1
        orbit.speed = 100.0
        orbit.calculationMode = CAAnimationCalculationMode.cubic
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        progressCircle.add(orbit, forKey: "orbit")
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.speed = 100
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        progressLayer.strokeEnd = CGFloat(1)
        progressLayer.add(animation, forKey: "animateCircle")
    }
    
    func pauseProgress () {
        pauseLayer(layer: progressCircle)
        pauseLayer(layer: progressLayer)
    }
    
    func resumeProgress () {
        resumeLayer(layer: progressCircle)
        resumeLayer(layer: progressLayer)
    }
    
    func removeProgress () {
        removeLayer(layer: progressCircle)
        removeLayer(layer: progressLayer)
        
    }
    
    
}
