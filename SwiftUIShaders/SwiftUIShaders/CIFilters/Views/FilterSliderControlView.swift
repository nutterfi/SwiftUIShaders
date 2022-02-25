//
//  FilterSliderControlView.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/25/22.
//

import SwiftUI

struct FilterSliderControlView: View {
  @State private var value: Float = 0.0
  var viewModel: FilterSliderControlViewModel
  
  var body: some View {
    HStack {
      Text(viewModel.key)
        .foregroundColor(.white)
      let min = viewModel.minimumSliderValue ?? 0
      let max = viewModel.maximumSliderValue ?? 1
      Slider(value: $value, in: min...max)
        .onChange(of: value) { newValue in
          viewModel.update(newValue)
      }
    }
    .padding(.horizontal)
  }
}

struct FilterSliderControlView_Previews: PreviewProvider {
    static var previews: some View {
      FilterSliderControlView(viewModel: FilterSliderControlViewModel(key: "Test"))
    }
}
