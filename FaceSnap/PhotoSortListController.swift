//
//  PhotoSortListController.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-08.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class PhotoSortListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

}

extension PhotoSortListController {
    func setupNavigation() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PhotoSortListController.dismissPhotoSortListController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func dismissPhotoSortListController() {
        dismiss(animated: true, completion: nil)
    }
}
