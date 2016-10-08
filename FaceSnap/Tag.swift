//
//  Tag.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-06.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import CoreData

class Tag: NSManagedObject {
    static let entityName = "\(Tag.self)"
    
    static var allTagsRequest: NSFetchRequest<Tag> = {
        let request = NSFetchRequest<Tag>(entityName: Tag.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        return request
    }()
    
    class func tag(withTitle title: String) -> Tag {
        let tag = NSEntityDescription.insertNewObject(forEntityName: Tag.entityName, into: CoreDataController.sharedInstance.managedObjectContext) as! Tag
        tag.title = title
        
        return tag
    }
}

extension Tag {
    @NSManaged var title: String
}
