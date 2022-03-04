//
//  FilterSliderControlView.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/25/22.
//

import SwiftUI

struct FilterToggleControlView: View {
  @State private var value: Bool = false
  var viewModel: FilterToggleControlViewModel
  
  var body: some View {
    HStack {
      Toggle(isOn: $value) {
        Text(viewModel.key)
      }
      .onChange(of: value) { newValue in
        viewModel.update(newValue)
      }
    }
    .padding(.horizontal)
  }
}


struct FilterSliderControlView: View {
  @State private var value: Float = 0.0
  var viewModel: FilterSliderControlViewModel
  
  var body: some View {
    HStack {
      Text(viewModel.key)
        .foregroundColor(.white)
      let min = viewModel.minimumSliderValue ?? 0
      let max = viewModel.maximumSliderValue ?? 1
      let step = (max - min) / 10
      Slider(value: $value, in: min...max, step: step)
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
