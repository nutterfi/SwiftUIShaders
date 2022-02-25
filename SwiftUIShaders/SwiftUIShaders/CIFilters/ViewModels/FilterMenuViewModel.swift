//
//  FilterMenuViewModel.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/24/22.
//

import SwiftUI

struct FilterMenuViewModelItem {
  var image: CIImage
  var filter: CIFilter
  var name: String
}

class FilterMenuViewModel: ObservableObject {
  @Published var images: [CIImage] = []
  @Published var names: [String] = []
  
  private var filters: [CIFilter] = []

  private var dispatchQueue = DispatchQueue(label: "FilterMenuViewModel")
  
  // TODO: provide customized input image
  let image = CIImage(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "hello", ofType: "png")!))
  
  func item(at index: Int) -> FilterMenuViewModelItem? {
    guard index < filters.count else { return nil }
    return FilterMenuViewModelItem(image: images[index], filter: filters[index], name: names[index])
  }
  
  init() {
    dispatchQueue.async {
      let categories = CIFilter.categories()
      var filterNames: Set<String> = []
      categories.forEach { category in
        filterNames.formUnion(CIFilter.filterNames(inCategory: category) )
      }
      
      var filters = [CIFilter]()
      var outputImages = [CIImage]()
      var names = [String]()
      let orderedFilterNames = Array(filterNames).sorted()
      orderedFilterNames.forEach { name in
        if let filter = CIFilter(name: name), filter.inputKeys.contains(kCIInputImageKey) {
          filter.setValue(self.image, forKey: kCIInputImageKey)
          if let outputImage = filter.outputImage {
            filters.append(filter)
            outputImages.append(outputImage)
            names.append(filter.name)
          }
        }
      }
      
      DispatchQueue.main.async {
        self.filters = filters
        self.images = outputImages
        self.names = names
      }
     
    }
    
  }
}
