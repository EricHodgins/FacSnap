//
//  PhotoDataSource.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-06.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import CoreData

class PhotoDataSource {
    let collectionView: UICollectionView
    let managedObjectContext = CoreDataController.sharedInstance.managedObjectContext
    let fetchedResultsController: PhotoFetchedResultsController
    
    init(fetchRequest: NSFetchRequest<Photo>, collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.fetchedResultsController = PhotoFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, collectionView: self.collectionView)
    }
}
