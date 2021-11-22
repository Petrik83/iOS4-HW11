//
//  ViewController.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    let circularProgress = CircularProgress(frame: CGRect(x: 10.0, y: 30.0, width: 100.0, height: 100.0))
    var timer: Timer?
    var timeLeft = 2500
    var isWorkTime = true
    var sceneColor = UIColor.brown
    
    func changeSceneColor (color: UIColor) {
        circularProgress.trackColor = color
        playButton.tintColor = color
        pauseButton.tintColor = color
        timerLabel.textColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeSceneColor(color: sceneColor)
//        circularProgress.trackColor = sceneColor
        circularProgress.tag = 101
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        pauseButton.isHidden = true
        playButton.isHidden = false
        playButton.setImage(UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
//        playButton.tintColor = sceneColor
        
        pauseButton.setImage(UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
//        pauseButton.tintColor = sceneColor
        
//        timerLabel.textColor = sceneColor
        timerLabel.text = "\(timeConverter(time: timeLeft))"
        
        
    }

    @objc func animateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.setProgressWithAnimation(duration: Double(timeLeft))
       }
    
    @objc func pauseAnimateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.pauseProgress()
       }
    
    @objc func resumeAnimateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.resumeProgress()
       }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    @objc func onTimerFires() {
        
        timeLeft -= 1
        timerLabel.text = "\(timeConverter(time: timeLeft))"
     
        if (timeLeft <= 0) && isWorkTime {
            sceneColor = UIColor.green
            changeSceneColor(color: sceneColor)
            timeLeft = 500
            self.perform(#selector(animateProgress), with: nil, afterDelay: 0)
            isWorkTime = false
        } else {
            if (timeLeft <= 0) && !isWorkTime {
                sceneColor = UIColor.brown
                changeSceneColor(color: sceneColor)
                timeLeft = 2500
                self.perform(#selector(animateProgress), with: nil, afterDelay: 0)
                isWorkTime = true
            }
        }
    }
    

    @IBAction func playButtonPressed(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
                //animate progress
        switch timeLeft {
        case 500, 2500, 150000, 30000:
            self.perform(#selector(animateProgress), with: nil, afterDelay: 0)
        default:
            resumeAnimateProgress()
        }
        pauseButton.isHidden = false
        playButton.isHidden = true
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        timer?.invalidate()
        pauseAnimateProgress()
        pauseButton.isHidden = true
        playButton.isHidden = false
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
    }
}

