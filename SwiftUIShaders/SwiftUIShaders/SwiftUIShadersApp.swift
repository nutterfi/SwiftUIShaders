//
//  SwiftUIShadersApp.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/9/22.
//

import SwiftUI

// Desired Feature Set
// Show all available filters -- DONE
// Provide input image -- image library, or from preselected shapes from Shapes library
// choose filter to customize the input parameters AND SAVE customized settings as favorite filters
// export the image via save to library or print somewhere
// Shaders?
// allow user to import Shader code in the form of string pasted into a textfield or via a file
//

@main
struct SwiftUIShadersApp: App {
  var body: some Scene {
    WindowGroup {
      FilterMenu()
    }
  }
}
