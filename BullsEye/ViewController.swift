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
    let message = "Текущее значение: \(currentValue)\n" + "Ты получил \(currentScore) \(scoreEnding())"
    let alert = UIAlertController(title: alertTitle(), message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonTitle(), style: .default, handler: {
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
    let difference = abs(targetValue - currentValue)
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
  
  func scoreEnding() -> String {
    let ending: String
    if currentScore == 1 {
      ending = "балл"
    } else if currentScore > 1 && currentScore < 5 {
      ending = "балла"
    } else {
      ending = "баллов"
    }
    return ending
  }
  
  func buttonTitle() -> String {
    let title: String
    if attempt > 1 {
      title = "Продолжить"
    } else {
      title = "Заново"
    }
    return title
  }
  
  func alertTitle() -> String {
    let difference = abs(targetValue - currentValue)
    let title: String
    if attempt > 1 {
      if difference == 0 {
        title = "В яблочко!"
      } else if difference <= 10 {
        title = "Цель была близко!"
      } else if difference <= 100 {
        title = "Неплохо"
      } else {
        title = "Ты вообще пытаешься?"
      }
    } else {
      title = "Твой счет: \(score)"
    }
    return title
  }
}
