//
//  FilterDetailViewModel.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/24/22.
//

import UIKit
import CoreImage
import Combine

class FilterDetailViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case ready
    case error
  }
  
  @Published private(set) var state = State.idle
  @Published private(set) var image: CIImage?
  
  private var filter: CIFilter?
  
  private var subscriptions = Set<AnyCancellable>()
  
  @Published var items = [FilterSliderControlViewModel]()

  func load(filter: CIFilter) {
    self.filter = filter
    self.state = .loading
    loadItems()
  }
  
  func loadItems() {
    inputs().forEach { inputKey in
      guard let filter = filter,
              let attributes = filter.attributes[inputKey] as? Dictionary<String, Any>,
            let className = attributes[kCIAttributeClass] as? String else {
              return
            }
      
      // TODO: return appropriate view model for className
      var item: FilterSliderControlViewModel?
      switch className {
      case "CIImage": // input image
        break
      case "NSData":
        break
      case "NSNumber":
        if let type = attributes[kCIAttributeType] as? String {
          switch type {
          case kCIAttributeTypeBoolean:
            break
          case kCIAttributeTypeCount, kCIAttributeTypeScalar, kCIAttributeTypeInteger, kCIAttributeTypeDistance:
            item = FilterSliderControlViewModel(key: inputKey, value: 0, attributes: attributes)
          default: break
          }
        } else {
          item = FilterSliderControlViewModel(key: inputKey, value: 0, attributes: attributes)
        }
      default: break
      }
      guard let item = item else { return }
      
      items.append(item)
      item.$value.sink { [weak self] newValue in
        DispatchQueue.main.async {
          self?.filter?.setValue(newValue, forKey: item.key)
          self?.image = self?.filter?.outputImage
        }
      }.store(in: &subscriptions)
    }
    self.state = .ready
  }
  
  func inputs() -> [String] {
    filter?.inputKeys ?? []
  }
  
  func outputs() -> [String] {
    filter?.outputKeys ?? []
  }
}
