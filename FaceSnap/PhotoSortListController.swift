//
//  PhotoSortListController.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-08.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import CoreData

class PhotoSortListController<SortType: CustomTitleConvertible>: UITableViewController where SortType: NSManagedObject {
    
    let dataSource: SortableDataSource<SortType>
    
    init(dataSource: SortableDataSource<SortType>) {
        self.dataSource = dataSource
        super.init(style: .grouped)
        
        tableView.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PhotoSortListController.dismissPhotoSortListController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func dismissPhotoSortListController() {
        dismiss(animated: true, completion: nil)
    }

}

