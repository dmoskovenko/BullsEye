//
//  AboutView.swift
//  BullsEye
//
//  Created by dima on 13/04/2020.
//  Copyright © 2020 Dmitry Moskovenko. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
  struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .padding(.bottom, 20)
        .padding(.top, 20)
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
    }
  }
  
  struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 19))
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("BullsEye©").modifier(AboutHeadingStyle())
        Text("Это игра, в которой можно выигрывать баллы, перетаскивая ползунок.").modifier(AboutBodyStyle())
        Text("Твоя цель - расположить ползунок как можно ближе к заданному значению.").modifier(AboutBodyStyle())
        Text("Чем ближе, тем больше баллов ты получишь.").modifier(AboutBodyStyle())
      }
 //     .background(biege)
      .navigationBarTitle("About BullsEye")
    }
    .background(Image("Background2"))
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView().previewLayout(.fixed(width: 896, height: 414))
  }
}
