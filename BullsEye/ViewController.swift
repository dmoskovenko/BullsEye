//
//  ViewController.swift
//  BullsEye
//
//  Created by dima on 11/08/2020.
//  Copyright © 2020 Dmitry Moskovenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var currentValue = 0
  var targetValue = 0
  var score = 0
  var currentScore = 0
  var attempt = 6
  var difference = 0
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var attemptLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let roundedValue = slider.value.rounded()
    currentValue = Int(roundedValue)
    startNewGame()
    
    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
    slider.setThumbImage(thumbImageNormal, for: .normal)
    
    let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    
    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)
  }

  @IBAction func showAlert() {
    currentScore = scoreForCurrentRound()
    let message = "The slider's value is: \(currentValue)\n" + "You scored \(currentScore) points this round."
    let alert = UIAlertController(title: alertTitle(), message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonText(), style: .default, handler: {
      action in
      self.startNewRound()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    
  }
    
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    currentValue = Int(roundedValue)
  }
  
  func startNewRound() {
    attempt -= 1
    if attempt == 0 {
      startNewGame()
    }
    score += currentScore
    targetValue = Int.random(in: 1...1000)
    currentValue = 500
    slider.value = Float(currentValue)
    updateLables()
  }
  
  @IBAction func startNewGame() {
    score = 0
    currentScore = 0
    attempt = 6
    currentValue = 0
    startNewRound()
  }
  
  func updateLables() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    attemptLabel.text = String(attempt)
  }
  
  func scoreForCurrentRound() -> Int {
    let maxScore = 100
    difference = getDifference()
    var bonus = 0
    if difference == 0 {
      bonus = 100
    } else if difference <= 10 {
      bonus = 50
    } else if difference > 100 {
      return 0
    }
    return maxScore - difference + bonus
  }
  
  func getDifference() -> Int {
    return abs(targetValue - currentValue)
  }
  
  func buttonText() -> String {
    return (attempt > 1) ? "Continue" : "Restart"
  }
  
  func alertTitle() -> String {
    let title: String
    if attempt > 1 {
      if difference == 0 {
        title = "Perfect!"
      } else if difference <= 10 {
        title = "You almost had it!"
      } else if difference <= 100 {
        title = "Not bad"
      } else {
        title = "Are you even trying?"
      }
    } else {
      title = "Your score: \(score)"
    }
    return title
  }
}
