//
//  ContentView.swift
//  BullsEye
//
//  Created by dima on 11/04/2020.
//  Copyright © 2020 Dmitry Moskovenko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State var alertIsVisible = false
  @State var sliderValue = 500.0
  @State var endOfGame = false
  @State var target = Int.random(in: 1...1000)
  @State var allPoint = 0
  @State var round = 5
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .modifier(Shadow())
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
        .modifier(Shadow())
    }
  }
  
  struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
  }
  
  struct PopupTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.green)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .modifier(Shadow())
    }
  }
  
  struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 14))
    }
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      // Target row
      HStack {
        Text("Выбей значение:").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
       
      // Slider row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...1000)
        Text("1000").modifier(LabelStyle())
      }
      Spacer()
      
      // Button row
      Button(action: {
        print("Hit button pressed!")
        self.alertIsVisible = true
      }) {
        Text("Проверить").modifier(ButtonLargeTextStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        print("Slider value is: \(sliderValue)")
        return Alert(title: Text(alertTitle()), message: Text(PushBodyText()
        ), dismissButton: .default(Text(PushButtonText())) {
          if self.round > 1 {
            self.allPoint += self.pointsForCurrentRound()
            self.round -= 1
            self.target = self.randomValue()
          } else {
            self.startNewGame()
          }
          })
      }
      .background(Image("Button")).buttonStyle(PlainButtonStyle())
      Spacer()
      
      // Score row
      HStack {
        Button(action: {
          print("Restart button pressed!")
          self.startNewGame()
        }) {
          HStack {
            Image("StartOverIcon")
            Text("Заново").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button")).buttonStyle(PlainButtonStyle())
        Spacer()
        Text("Счет:").modifier(LabelStyle())
        Text("\(allPoint)").modifier(ValueStyle())
        Spacer()
        Text("Попыток:").modifier(LabelStyle())
        Text("\(round)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("InfoIcon")
            Text("Инфо").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button")).buttonStyle(PlainButtonStyle())
      }
      .padding(.bottom, 20)
    }
    .background(Image("Background2"), alignment: .center)
    .navigationBarTitle("Bullseye")
  }
  
  func randomValue() -> Int {
    return Int.random(in: 1...1000)
  }
  
  func sliderValueRounded() -> Int {
    return Int(sliderValue.rounded())
  }
  
  func pointsForCurrentRound() -> Int {
    let maximumScore = 100
    let difference = amountOff()
    var bonus = 0
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    } else if difference > 50 {
      return 0
    }
    return maximumScore - difference + bonus
  }
  
  func amountOff() -> Int {
    return abs(target - sliderValueRounded())
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    let title: String
    if round <= 1 {
      if allPoint > 0 {
        title = "Победа!"
      } else {
        title = "Проигрыш..."
      }
    }
    else {
      if difference == 0 {
        title = "Ура! В яблочко!"
      } else if difference < 10 {
        title = "Цель была близко!"
      } else if difference <= 50 {
        title = "Неплохо"
      } else {
        title = "Ты вообще пытаешься?"
      }
    }
    return title
  }
  
  func pointEnding() -> String {
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
  
  func PushButtonText() -> String {
    let buttonText: String
      if round > 1 {
        buttonText = "Продолжить"
      } else {
        buttonText = "Сыграть еще раз"
    }
    return buttonText
  }
  
  func PushBodyText() -> String {
    var bodyText = "Значение слайдера: \(sliderValueRounded()).\n" +
        "Ты получаешь \(self.pointsForCurrentRound()) \(pointEnding()) за раунд"
    if round <= 1 {
        bodyText += "\nТвой счет: \(allPoint)"
    }
    return bodyText
  }
  
  func startNewGame() -> Void {
    round = 5
    allPoint = 0
    sliderValue = 500.0
    target = randomValue()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}
