//
//  FilterMenu.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/22/22.
//

import SwiftUI

struct FilterMenu: View {
  @StateObject private var viewModel = FilterMenuViewModel()
  
  let gridItems = [GridItem(), GridItem(), GridItem()]
  
  var body: some View {
    NavigationView {
      VStack {
        Image("hello")
          .resizable()
          .scaledToFit()
          .frame(width: 256, height: 256)
        
        Text("Filters: \(viewModel.images.count)")
        ScrollView(.vertical) {
          LazyVGrid(columns: gridItems) {
            ForEach(0..<viewModel.images.count, id: \.self) { index in
              if let item = viewModel.item(at: index) {
                let image = viewModel.images[index]
                NavigationLink {
                  NavigationLazyView(FilterDetailView(item: item))
                } label: {
                  FilterMenuItem(image: image, name: item.name)
                    .frame(width: 150, height: 150)
                }
              }
            }
          }
        }
        
        Spacer()
      }
    }
    
  }
}

struct FilterMenu_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FilterMenu()
    }
  }
}
