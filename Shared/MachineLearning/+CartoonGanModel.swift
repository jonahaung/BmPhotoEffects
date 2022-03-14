//
//  +CartoonGanModel.swift
//  BmPhotoEffects
//
//  Created by Aung Ko Min on 14/3/22.
//

import UIKit
import CoreML

extension AIModel {
    
    func process(image: UIImage, selectedNSTModel: NSTDemoModel) {
        
        var outputImage: UIImage?
        var nstError: Error?
        
        queue.async {
            do {
                let modelProvider = try selectedNSTModel.modelProvider()
                outputImage = try modelProvider.prediction(inputImage: image)
            } catch let error {
                nstError = error
            }
            if let outputImage = outputImage {
                self.delegate?.model(self, didFinishProcessing: outputImage)
            } else if let nstError = nstError{
                print(nstError)
                self.delegate?.model(self, didFailedProcessing: .preprocess)
            } else {
                self.delegate?.model(self, didFailedProcessing: .unknown)
            }
            
        }
    }
}
