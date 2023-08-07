//
//  Workout.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

//import Foundation
//import CoreData
//
//class Workout: NSManagedObject {
//    @NSManaged public var desc: String
//    @NSManaged public var id: UUID
//    @NSManaged public var name: String
//    @NSManaged public var exercises: NSSet
//}
//
////FROM:https://stackoverflow.com/questions/52377909/coredata-warning-multiple-nsentitydescriptions-claim-the-nsmanagedobject-subcla/72161126#72161126
////SOLVED: Multiple entities own class Workout error
//extension NSManagedObject {
//    convenience init(context: NSManagedObjectContext) {
//        let name = String(describing: type(of: self))
//        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
//        self.init(entity: entity, insertInto: context)
//    }
//}
