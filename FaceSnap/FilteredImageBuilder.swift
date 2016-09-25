//
//  FilteredImageBuilder.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-09-25.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import CoreImage

struct PhotoFilter {
    
    static let ColorClamp = "CIColorClamp"
    
    static func defaultFilters() -> [CIFilter] {
        let colorClamp = CIFilter(name: PhotoFilter.ColorClamp)!
        colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
        colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMinComponents")
        
        return [colorClamp]
    }
}
