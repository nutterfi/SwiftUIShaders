//
//  FilterSliderControlViewModel.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/25/22.
//

import Foundation
import Combine
import CoreImage

// this will be used to load slider control with initial value
class FilterSliderControlViewModel: ObservableObject {
  
  let key: String // inputKey supplied by the CIFilter
  @Published var value: Float
  
  var defaultValue: Float?
  var minimumValue: Float?
  var maximumValue: Float?
  
  var minimumSliderValue: Float?
  var maximumSliderValue: Float?
  
  var identityValue: Any? // HUH?
  var type: Any? // see kCIAttributeType
  
  internal required init(key: String, value: Any? = nil, attributes: Dictionary<String, Any> = [:]) {
    self.key = key
    
    self.defaultValue = attributes[kCIAttributeDefault] as? Float
    self.minimumValue = attributes[kCIAttributeMin] as? Float
    self.maximumValue = attributes[kCIAttributeMax] as? Float
    self.minimumSliderValue = attributes[kCIAttributeSliderMin] as? Float
    self.maximumSliderValue = attributes[kCIAttributeSliderMax] as? Float
    self.identityValue = attributes[kCIAttributeIdentity]
    self.type = attributes[kCIAttributeType]
    
    if let value = value as? Float {
      self.value = value
    } else if let defaultValue = self.defaultValue {
      self.value = defaultValue
    } else if let identityValue = self.defaultValue {
      self.value = identityValue
    } else if let minimumValue = self.minimumValue {
      self.value = minimumValue
    } else {
      self.value = 0
    }
  }
  
  func update(_ newValue: Float) {
    print(newValue)
    self.value = newValue
  }
}
