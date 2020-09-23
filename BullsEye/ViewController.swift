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
  var attempt = 11
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var attemptLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedValue = slider.value.rounded()
    currentValue = Int(roundedValue)
    startNewRound()
  }

  @IBAction func showAlert() {
    
    let message = "Ты получил \(pointsForCurrentRound()) \(scoreEnding())"
    let alert = UIAlertController(title: alertTitle(), message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
    startNewRound()
    
  }
    
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    currentValue = Int(roundedValue)
  }
  
  func startNewRound() {
    attempt -= 1
    targetValue = Int.random(in: 1...1000)
    currentValue = 500
    slider.value = Float(currentValue)
    updateLables()
  }
  
  func updateLables() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    attemptLabel.text = String(attempt)
  }
  
  func pointsForCurrentRound() -> Int {
    let maxScore = 100
    let difference = abs(targetValue - currentValue)
    var bonus = 0
    if difference == 0 {
      bonus = 100
    } else if difference <= 10 {
      bonus = 50
    } else if difference > 50 {
      return 0
    }
    return maxScore - difference + bonus
  }
  
  func scoreEnding() -> String {
    let ending: String
    if pointsForCurrentRound() == 1 {
      ending = "балл"
    } else if pointsForCurrentRound() > 1 &&  pointsForCurrentRound() < 5 {
      ending = "балла"
    } else {
      ending = "баллов"
    }
    return ending
  }
  
  func alertTitle() -> String {
    let difference = abs(targetValue - currentValue)
    let title: String
    if attempt <= 1 {
      if score > 0 {
        title = "Победа!"
      } else {
        title = "Проигрыш..."
      }
    }
    else {
      if difference == 0 {
        title = "В яблочко!"
      } else if difference <= 10 {
        title = "Цель была близко!"
      } else if difference <= 50 {
        title = "Неплохо"
      } else {
        title = "Ты вообще пытаешься?"
      }
    }
    return title
  }
}

