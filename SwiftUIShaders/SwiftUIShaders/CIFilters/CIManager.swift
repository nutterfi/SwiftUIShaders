//
//  CIManager.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/12/17.
//

import UIKit

// holds onto a context
class CIManager {
  static let context = CIContext()
  
  static func cgImage(from image: CIImage) -> CGImage? {
    return CIManager.context.createCGImage(image, from: image.extent)
  }
}
