//
//  SortableDataSource.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-08.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit
import CoreData

protocol CustomTitleConvertible {
    var title: String { get }
}

extension Tag: CustomTitleConvertible {}

class SortableDataSource<SortType: CustomTitleConvertible>: NSObject, UITableViewDataSource where SortType: NSManagedObject {
    
    let fetchedResultsController: NSFetchedResultsController<SortType>
    
    init(fetchRequest: NSFetchRequest<SortType>, managedObjectContex moc: NSManagedObjectContext) {
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("unresolved error.")
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return fetchedResultsController.fetchedObjects?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "sortableItemCell")
        cell.selectionStyle = .none
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.textLabel?.text = "All \(SortType.self)s"
            cell.accessoryType = .checkmark
        case (1, _):
            guard let sortItem = fetchedResultsController.fetchedObjects?[indexPath.row] else {
                break
            }
            
            cell.textLabel?.text = sortItem.title
            
        default:
            break
        }
        
        return cell
    }
}
























