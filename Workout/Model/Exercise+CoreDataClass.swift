//
//  Exercise+CoreDataClass.swift
//  Workout
//
//  Created by Aidan Katz on 8/6/23.
//
//

import Foundation
import CoreData


public class Exercise: NSManagedObject {
    
}

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
