//
//  Exercise+CoreDataProperties.swift
//  Workout
//
//  Created by Aidan Katz on 8/6/23.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var sets: String
    @NSManaged public var reps: String
    @NSManaged public var rest: String
    @NSManaged public var workout: Workout?

}

extension Exercise : Identifiable {

}
