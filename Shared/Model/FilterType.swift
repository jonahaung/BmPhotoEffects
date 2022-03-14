//
//  FilterType.swift
//  BmPhotoEffects
//
//  Created by Aung Ko Min on 14/3/22.
//

import Foundation

enum FilterType: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case Cartoon, VanGogh, Pointillism
}
