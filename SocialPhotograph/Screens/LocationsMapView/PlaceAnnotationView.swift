//
//  PlaceAnnotationView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI

struct PlaceAnnotationView: View {
  let name: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(name)
        .font(.callout)
        .padding(5)
        .background(Color(uiColor: .white))
        .cornerRadius(10)
        .foregroundColor(Color(uiColor: .black))
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
  }
}

struct PlaceAnnotationView_Previews: PreviewProvider {
  static var previews: some View {
    PlaceAnnotationView(name: "Bondi Beach")
      .background(Color.gray)
  }
}
