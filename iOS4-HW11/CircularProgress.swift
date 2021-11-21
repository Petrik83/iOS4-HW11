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
    
    var progressColor: UIColor = UIColor.green {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = UIColor.green {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
            progressCircle.strokeColor = trackColor.cgColor
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
        layer.addSublayer(tracklayer)
        
        let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: (frame.size.height / 2.0) - 100), radius: CGFloat(10), startAngle: CGFloat(-0.5 * Double.pi),
                                           endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        progressCircle.path = smallCirclePath.cgPath
        progressCircle.fillColor = UIColor.white.cgColor
        progressCircle.strokeColor = trackColor.cgColor
        progressCircle.lineWidth = 3.0;
        progressCircle.strokeEnd = 1.0
        layer.addSublayer(progressCircle)
    }
    
    func setProgressWithAnimation(duration: TimeInterval) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: CGFloat(35), startAngle: CGFloat(-0.67 * Double.pi),
                                      endAngle: CGFloat(1.33 * Double.pi), clockwise: true)
        
        let orbit = CAKeyframeAnimation(keyPath: "position")
        var affineTransform = CGAffineTransform(rotationAngle: 0.0)
        affineTransform = affineTransform.rotated(by: CGFloat(Double.pi))
        let initialPoint = CGPoint(x: 0, y: 0)
        circlePath.move(to: initialPoint)
        orbit.path = circlePath.cgPath
        orbit.duration = duration
        orbit.isAdditive = true
        orbit.repeatCount = 3
        orbit.calculationMode = CAAnimationCalculationMode.cubic
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        progressCircle.add(orbit, forKey: "orbit")
        
    }
    
}
