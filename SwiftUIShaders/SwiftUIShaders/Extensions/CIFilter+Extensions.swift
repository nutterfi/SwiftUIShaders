//
//  CIFilter+Extensions.swift
//  CoreImageNinja
//
//  Created by nutterfi on 2/17/17.
//  Copyright © 2017 nutterfi. All rights reserved.
//

import CoreImage

extension CIFilter {
  static func categories() -> [String] {
    var categories = [String]()
    
    categories.append(kCICategoryDistortionEffect)
    categories.append(kCICategoryGeometryAdjustment)
    categories.append(kCICategoryCompositeOperation)
    categories.append(kCICategoryHalftoneEffect)
    categories.append(kCICategoryColorAdjustment)
    categories.append(kCICategoryColorEffect)
    categories.append(kCICategoryTransition)
    categories.append(kCICategoryTileEffect)
    categories.append(kCICategoryGenerator)
    
    if #available(iOS 5, *) {
      categories.append(kCICategoryReduction)
      categories.append(kCICategoryGradient)
      categories.append(kCICategoryStylize)
      categories.append(kCICategorySharpen)
      categories.append(kCICategoryBlur)
      categories.append(kCICategoryVideo)
      categories.append(kCICategoryStillImage)
      categories.append(kCICategoryInterlaced)
      categories.append(kCICategoryNonSquarePixels)
      categories.append(kCICategoryHighDynamicRange)
      categories.append(kCICategoryBuiltIn)
    }
    
    if #available(iOS 9, *) {
      categories.append(kCICategoryFilterGenerator)
    }
    
    return categories
  }
}
