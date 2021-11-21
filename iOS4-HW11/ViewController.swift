//
//  ViewController.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let circularProgress = CircularProgress(frame: CGRect(x: 10.0, y: 30.0, width: 100.0, height: 100.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        circularProgress.trackColor = UIColor.green
        circularProgress.tag = 101
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        
    }

    @objc func animateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.setProgressWithAnimation(duration: 5.0)
       }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
            
//                circularProgress.trackColor = UIColor.yellow
        
                //animate progress
                self.perform(#selector(animateProgress), with: nil, afterDelay: 0)
        
        
        
    }
    
    
}

