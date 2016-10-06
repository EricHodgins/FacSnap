//
//  Location.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-06.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    
}

extension Location {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}
