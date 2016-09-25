//
//  MediaPickerManager.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-09-24.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import MobileCoreServices

class MediaPickerManager: NSObject, UIImagePickerControllerDelegate {
    private let imagePickerController = UIImagePickerController()
    private let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        super.init()

//        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .front
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
    }
    
    func presentImagePickerController(animated: Bool) {
        presentingViewController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func dismissImageController(animated: Bool, completion: @escaping (() -> Void)) {
        imagePickerController.dismiss(animated: true, completion: completion)
    }
    
}
