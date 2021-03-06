//
//  ViewController.swift
//  catchTheKenny
//
//  Created by Nika Kalandia on 4.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var score1 = 0
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!

    @IBOutlet weak var againButt: UIButton!
    
    var timer = Timer()
    var counter = 10
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScores = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        againButt.isHidden = true
        
        againButt.layer.cornerRadius = 15
        againButt.layer.masksToBounds = true
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScoreZ")
        
        if storedHighScore == nil {
            highScores = 0
            highScore.text = "Highscore: \(highScores)"

        }
        
        if let newScore = storedHighScore as? Int {
            highScores = newScore
            highScore.text = "Highscore: \(highScores)"
            
        }
        
        time.text = "Time; \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        score.text = "Score: \(score1)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        hideKenny()
        
        
    }
    
    
    @IBAction func againButton(_ sender: Any) {
        
        againButt.isHidden = true
        
        for kenny in self.kennyArray {
            kenny.isUserInteractionEnabled = true
        }
        
        score1 = 0
        score.text = "Score: \(score1)"
        
        counter = 10
        time.text = "Time; \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
        
        
    }
    
    @objc func increaseScore(){
        
        score1 = score1 + 1
        score.text = "\(score1)"
        
        
    }
    
    @objc func timerFunc() {
        
        counter = counter - 1
        time.text = "Time; \(counter)"

        
        // When time's over
        
        if counter == -1 {
            
            timer.invalidate()
            hideTimer.invalidate()
            time.text = "Time's Over!"
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if self.score1 > self.highScores {
                self.highScores = self.score1
                highScore.text = "Highscore: \(self.highScores)"
                UserDefaults.standard.setValue(self.highScores, forKey: "highScoreZ")
                
            }
            
            
            let alert = UIAlertController(title: "Time's Over!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                
                for kenny in self.kennyArray {
                    kenny.isHidden = false
                    kenny.isUserInteractionEnabled = false
                    self.againButt.isHidden = false
                }
                
            }
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score1 = 0
                self.score.text = "Score: \(self.score1)"
                
                self.counter = 10
                self.time.text = "Time; \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)


            }
            
            alert.addAction(okButton)
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }


}

}
