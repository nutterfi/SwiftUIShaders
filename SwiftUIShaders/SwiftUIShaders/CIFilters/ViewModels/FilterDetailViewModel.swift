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
  
  private var item: FilterMenuViewModelItem?
  
  private var subscriptions = Set<AnyCancellable>()
    
  @Published var inputItems = [FilterViewModel]()

  func load(item: FilterMenuViewModelItem) {
    self.item = item
    self.state = .loading
    loadItems()
  }
  
  func loadItems() {
    inputs().forEach { inputKey in
      guard let filter = item?.filter,
              let attributes = filter.attributes[inputKey] as? Dictionary<String, Any>,
            let className = attributes[kCIAttributeClass] as? String else {
              return
            }
      
      // TODO: return appropriate view model for className
      var item: FilterViewModel?
      switch className {
      case "CIImage": // input image
        break
      case "NSData":
        break
      case "NSNumber":
        if let type = attributes[kCIAttributeType] as? String {
          switch type {
          case kCIAttributeTypeBoolean:
            let vm = FilterToggleControlViewModel(key: inputKey, value: attributes[kCIAttributeDefault] as? Bool)
            vm.$value.sink { [weak self] newValue in
              self?.item?.dispatchQueue.async {
                self?.item?.filter.setValue(newValue, forKey: vm.key)
                DispatchQueue.main.async {
                  self?.image = self?.item?.filter.outputImage
                }
              }
            }.store(in: &subscriptions)
            item = vm
          case kCIAttributeTypeCount, kCIAttributeTypeScalar, kCIAttributeTypeInteger, kCIAttributeTypeDistance:
            let vm = FilterSliderControlViewModel(key: inputKey, value: attributes[kCIAttributeDefault], attributes: attributes)
            
            vm.$value.sink { [weak self] newValue in
              self?.item?.dispatchQueue.async {
                self?.item?.filter.setValue(newValue, forKey: vm.key)
                DispatchQueue.main.async {
                  self?.image = self?.item?.filter.outputImage
                }
              }
            }.store(in: &subscriptions)
            
            item = vm
            
          default: break
          }
        } else {
          let vm = FilterSliderControlViewModel(key: inputKey, value: attributes[kCIAttributeDefault], attributes: attributes)
          vm.$value.sink { [weak self] newValue in
            self?.item?.dispatchQueue.async {
              self?.item?.filter.setValue(newValue, forKey: vm.key)
              DispatchQueue.main.async {
                self?.image = self?.item?.filter.outputImage
              }
            }
          }.store(in: &subscriptions)
          
          item = vm
        }
      default: break
      }
      guard let item = item else { return }
      
      inputItems.append(item)
      
    }
    self.state = .ready
  }
  
  func inputs() -> [String] {
    item?.filter.inputKeys ?? []
  }
  
  func outputs() -> [String] {
    item?.filter.outputKeys ?? []
  }
}
