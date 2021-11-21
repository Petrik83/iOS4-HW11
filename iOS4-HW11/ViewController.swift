//
//  ViewController.swift
//  iOS4-HW11
//
//  Created by Александр Петрович on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
    }

    @objc func animateProgress() {
           let cp = self.view.viewWithTag(101) as! CircularProgress
           cp.setProgressWithAnimation(duration: 5.0, value: 0.8)
       }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        
       
        let circularProgress = CircularProgress(frame: CGRect(x: 10.0, y: 30.0, width: 100.0, height: 100.0))
                circularProgress.progressColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 1.0)
                circularProgress.trackColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 0.6)
                circularProgress.tag = 101
                circularProgress.center = self.view.center
                self.view.addSubview(circularProgress)
                
                //animate progress
                self.perform(#selector(animateProgress), with: nil, afterDelay: 1)
        
        
        
    }
    
    
}

