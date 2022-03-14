//
//  MainViewManager.swift
//  BmPhotoEffects (iOS)
//
//  Created by Aung Ko Min on 14/3/22.
//

import UIKit

class MainViewManager: NSObject, ObservableObject {
    
    private lazy var aiModel: AIModel = {
        let model = AIModel()
        model.delegate = self
        return model
    }()
    @Published var showSpinner = false
    @Published var resultImage: UIImage?
    @Published var errorMessage: String?
    @Published var filterType = FilterType.Cartoon
    
    func start() {
        aiModel.start()
    }
    func process(image: UIImage) {
        showSpinner = true
        switch filterType {
        case .Cartoon:
            aiModel.process(image)
        case .VanGogh:
            aiModel.process(image: image, selectedNSTModel: .starryNight)
        case .Pointillism:
            aiModel.process(image: image, selectedNSTModel: .pointillism)
        }
    }
}

extension MainViewManager: CartoonGanModelDelegate {
    func model(_ model: AIModel, didFinishProcessing image: UIImage) {
        DispatchQueue.main.async {
            self.showSpinner = false
            self.resultImage = image
            print(image)
        }
    }

    func model(_ model: AIModel, didFailedProcessing error: AIModelError) {
        DispatchQueue.main.async {
            self.showSpinner = false
            self.errorMessage = error.localizedDescription
            print(error)
        }
    }

    func model(_ model: AIModel, didFinishAllocation error: AIModelError?) {
        DispatchQueue.main.async {
            self.showSpinner = false
            guard let error = error else {
//                self.enabled = true
                return
            }
            self.errorMessage = error.localizedDescription
            print(error)
        }
    }
    
}
