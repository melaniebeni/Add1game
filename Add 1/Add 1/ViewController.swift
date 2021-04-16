//
//  ViewController.swift
//  Add 1
//
//  Created by Melanie Beni on 3/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var NumberLabel: UILabel!
    @IBOutlet weak var InputField: UITextField!
        var score = 0
           var timer:Timer?
           var seconds = 60
           
           override func viewDidLoad() {
               super.viewDidLoad()
               updateScoreLabel()
               updateNumberLabel()
               updateTimeLabel()
           }
           func updateScoreLabel() {
               ScoreLabel?.text = String(score)
           }
           func updateNumberLabel() {
               NumberLabel?.text = String.randomNumber(length: 4)
           }
           func updateTimeLabel() {

               let min = (seconds / 60) % 60
               let sec = seconds % 60

               TimeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
           }
           @IBAction func inputFieldDidChange(_ sender: Any) {
               guard let numberText = NumberLabel?.text, let inputText = InputField?.text else {
                   return
               }
               guard inputText.count == 4 else {
                   return
               }
               var isCorrect = true
               for n in 0..<4
               {
                   var input = inputText.integer(at: n)
                   let number = numberText.integer(at: n)
                   if input == 0 {
                       input = 10
                   }
                   if input != number + 1 {
                       isCorrect = false
                       break
                   }
               }
               if isCorrect {
                   score += 1
               } else {
                   score -= 1
               }
               updateNumberLabel()
               updateScoreLabel()
               InputField?.text = ""
               
               if timer == nil {
                   timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                       if self.seconds == 0 {self.finishGame() }
                       else if self.seconds <= 60 {
                           self.seconds -= 1
                           self.updateTimeLabel()
                       }
                   }
               }
           }
           func finishGame()
           {
               timer?.invalidate()
               timer = nil
               let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

               self.present(alert, animated: true, completion: nil)
               score = 0
               seconds = 60
               updateTimeLabel()
               updateScoreLabel()
               updateNumberLabel()
           }
       }


