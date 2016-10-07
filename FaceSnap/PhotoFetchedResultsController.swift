//
//  PhotoFetchedResultsController.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-06.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import CoreData

class PhotoFetchedResultsController: NSFetchedResultsController<Photo>, NSFetchedResultsControllerDelegate {
    
    let collectionView: UICollectionView
    
    init(fetchRequest: NSFetchRequest<Photo>, managedObjectContext: NSManagedObjectContext, collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try performFetch()
        } catch {
            print("Unresolved error.")
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
