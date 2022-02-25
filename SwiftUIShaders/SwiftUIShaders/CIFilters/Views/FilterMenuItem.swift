//
//  FilterMenuItem.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/24/22.
//

import SwiftUI

/// houses a filtered image
struct FilterMenuItem: View {
  var image: CIImage
  var name: String
  var body: some View {
    ZStack {
      if let cgImage = CIManager.cgImage(from: image) {
        Image(uiImage: UIImage(cgImage: cgImage))
          .resizable()
          .scaledToFit()
      }
      
      VStack {
        Spacer()
        Text(name).scaledToFit()
      }
    }
  }
}

struct FilterMenuItem_Previews: PreviewProvider {
    static var previews: some View {
      FilterMenuItem(image: CIImage(image: UIImage(named: "hello")!)!, name: "Hello")
        .previewLayout(.sizeThatFits)
      .frame(width: 256, height: 256)
    }
}
