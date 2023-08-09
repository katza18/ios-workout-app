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
////FROM:https://stackoverflow.com/questions/52377909/coredata-warning-multiple-nsentitydescriptions-claim-the-nsmanagedobject-subcla/72161126#72161126
////SOLVED: Multiple entities own class ____ error
extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
