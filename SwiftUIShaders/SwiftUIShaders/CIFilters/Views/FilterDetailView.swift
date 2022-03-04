//
//  FilterDetailView.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/24/22.
//

import SwiftUI

/*
 Step 1: Slider moves
 Step 2: Slider value is stored in another property
 Step 3: Listener(Parent View or the FilterDetailView to change of that property gets triggered
 Step 4: Listener tells the viewModel that is holding the filter "Hey - update your filter parameter for this particular value"
 Step 5: View Model does that
 Step 6: Filter gets changed which then changes the output image
 */

/**
 FilterDetailView  <--------> FilterDetailViewModel
   ||                                                   ||   ^
   ||                                                   ||    |
 - [FilterDetailControlView] <------> [FilterDetailControlViewModel] .valuedidchange
 */

struct FilterDetailView: View {
  @StateObject var viewModel = FilterDetailViewModel()
  var item: FilterMenuViewModelItem
  
  init(item: FilterMenuViewModelItem) {
    self.item = item
  }
  
  var filterView: some View {
    VStack {
      Group {
        Text(item.filter.name)
      }
        .foregroundColor(.white)
        .scaledToFit()
      
      // TODO: Provide support for all other possible input types
      ForEach (0..<viewModel.inputItems.count) { index in
        let item = viewModel.inputItems[index]
        switch item {
        case is FilterSliderControlViewModel:
          FilterSliderControlView(viewModel: item as! FilterSliderControlViewModel)
        case is FilterToggleControlViewModel:
          FilterToggleControlView(viewModel: item as! FilterToggleControlViewModel)
        default:
          EmptyView()
        }
        
      }
      
      Spacer()
      
      if let image = viewModel.image,
         let cgImage = CIManager.cgImage(from: image) {
        Image(uiImage: UIImage(cgImage: cgImage))
          .resizable()
          .scaledToFit()
      }

      Spacer()
    }
  }
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea().opacity(0.8)
      
      Group {
        switch viewModel.state {
        case .idle:
          Color.clear
        case .loading:
          ProgressView()
        case .ready:
          filterView
        case .error:
          Color.red
        }
      }
    }
    .onAppear() {
      viewModel.load(item: item)
    }
  }
}

struct FilterDetailViewDemo: View {
  let filter = CIFilter(name: "CIHoleDistortion")!
  let image = CIImage(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "hello", ofType: "png")!))!

  var body: some View {
    VStack {
      FilterDetailView(item: FilterMenuViewModelItem(image: image, filter: filter, name: "Hello", dispatchQueue: .main))
    }
    .onAppear {
      DispatchQueue.main.async {
        filter.setValue(self.image, forKey: kCIInputImageKey)
      }
    }
  }
}

struct FilterDetailView_Previews: PreviewProvider {
    static var previews: some View {
      FilterDetailViewDemo()
    }
}
