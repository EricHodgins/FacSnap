//
//  FilteredImageBuilder.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-09-25.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import CoreImage

final class FilteredImageBuilder {
    
    private struct PhotoFilter {
        
        static let ColorClamp = "CIColorClamp"
        static let ColorControls = "CIColorControls"
        static let PhotoEffectInstant = "CIPhotoEffectInstant"
        static let PhotoEffectProcess = "CIPhotoEffectProcess"
        static let PhotoEffectNoir = "CIPhotoEffectNoir"
        static let Sepia = "CISepiaTone"
        
        static func defaultFilters() -> [CIFilter] {
            // ColorClamp
            let colorClamp = CIFilter(name: PhotoFilter.ColorClamp)!
            colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
            colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
            
            // Color Controls
            let colorControls = CIFilter(name: PhotoFilter.ColorControls)!
            colorControls.setValue(0.1, forKey: kCIInputSaturationKey)
            
            // Photo Effects
            let photoEffectInstant = CIFilter(name: PhotoFilter.PhotoEffectInstant)!
            let photoEffectProcess = CIFilter(name: PhotoFilter.PhotoEffectProcess)!
            let photoEffectNoir = CIFilter(name: PhotoFilter.PhotoEffectNoir)!
            
            // Sepia
            let sepia = CIFilter(name: PhotoFilter.Sepia)!
            sepia.setValue(0.7, forKey: kCIInputIntensityKey)
            
            return [colorClamp, colorControls, photoEffectInstant, photoEffectProcess, photoEffectNoir, sepia]
        }
    }
    
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func imageWithDefaultFilters() -> [UIImage] {
        return image(withFilters: PhotoFilter.defaultFilters())
    }
    
    func image(withFilters filters: [CIFilter]) -> [UIImage] {
        return filters.map({ (ciFilter) -> UIImage in
            return image(image: self.image, withFilter: ciFilter)
        })
    }
    
    func image(image: UIImage, withFilter filter: CIFilter) -> UIImage {
        let inputImage = image.ciImage ?? CIImage(image: image)!
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        let outputImage = filter.outputImage!
        
        return UIImage(ciImage: outputImage)
    }
}




























