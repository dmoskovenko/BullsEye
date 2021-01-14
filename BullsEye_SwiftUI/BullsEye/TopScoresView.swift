//
//  TopScoresView.swift
//  BullsEye
//
//  Created by dima on 15/04/2020.
//  Copyright © 2020 Dmitry Moskovenko. All rights reserved.
//

import SwiftUI

struct TopScoresView: View {
  
  struct TopHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .padding(.bottom, 20)
        .padding(.top, 20)
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
    }
  }
  
  struct TopBodyStyle: ViewModifier {
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
    VStack {
      Spacer()
      Text("Лучшие").modifier(TopHeadingStyle())
//      Text("\Round").modifier(TopBodyStyle())      }
    }
  }

  struct TopScoresView_Previews: PreviewProvider {
    static var previews: some View {
      TopScoresView().previewLayout(.fixed(width: 896, height: 414))
    }
  }
}
