//
//  ImageClassificationService.swift
//  FixItFelix
//
//  Created by Prince Alvin Yusuf on 27/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import CoreML
import Vision


final class ImageClassificationService {
    
    
    var completionHandler: ((Prediction) -> ())?
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: ImageClassifier().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.handleClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Image Classifier ML model: \(error)")
        }
    }()
    
    func predict(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func handleClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results else {
            completionHandler?(Prediction.failed(error))
            return
        }
        guard let classifications = results as? [VNClassificationObservation],
            let bestClassification = classifications.first,
            let prediction = Prediction(classLabel: bestClassification.identifier) else {
                completionHandler?(Prediction.empty)
                return
        }
        completionHandler?(prediction)
    }
}

extension CGImagePropertyOrientation {
    
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}

