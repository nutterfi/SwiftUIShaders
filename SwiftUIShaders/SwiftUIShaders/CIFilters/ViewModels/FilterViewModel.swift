//
//  FilterViewModel.swift
//  SwiftUIShaders
//
//  Created by nutterfi on 2/26/22.
//

import Foundation

protocol FilterViewModel: AnyObject {
    var key: String { get }    
    init(key: String, value: Any?, attributes: Dictionary<String, Any>)
}
