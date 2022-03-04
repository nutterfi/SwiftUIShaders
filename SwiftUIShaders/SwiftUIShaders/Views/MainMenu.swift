//
//  MainMenu.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/26/22.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
      TabView {
        FilterMenu()
          .tabItem {
            Text("CIFilters")
          }
        
        ShaderTestView()
          .tabItem {
            Text("Shaders")
          }
      }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
