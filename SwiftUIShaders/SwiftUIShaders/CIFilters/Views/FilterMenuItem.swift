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
  @State private var cgImage: CGImage?
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(.secondary)
      if let cgImage = cgImage {
        Image(uiImage: UIImage(cgImage: cgImage))
          .resizable()
          .scaledToFit()
      }
      
      VStack {
        Spacer()
        Text(name).scaledToFit()
      }
    }
    .onAppear {
      DispatchQueue.global().async {
        let cgImage = CIManager.cgImage(from: image)
        DispatchQueue.main.async {
          self.cgImage = cgImage
        }
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
