//
//  ViewController.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    let circularProgress = CircularProgress(frame: CGRect(x: 10.0, y: 30.0, width: 100.0, height: 100.0))
    var timer: Timer?
    var timeLeft = 10
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        circularProgress.trackColor = UIColor.green
        circularProgress.tag = 101
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        
        button.setImage(UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.tintColor = UIColor.green
        
        timerLabel.textColor = UIColor.green
        timerLabel.text = "\(timeConverter(time: timeLeft))"
        
        
    }

    @objc func animateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.setProgressWithAnimation(duration: Double(timeLeft))
       }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timerLabel.text = "\(timeConverter(time: timeLeft))"
     
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
            
//                circularProgress.trackColor = UIColor.yellow
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)

        
                //animate progress
                self.perform(#selector(animateProgress), with: nil, afterDelay: 0)
        
        
        
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
    }
    
}

