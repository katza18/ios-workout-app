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
    @NSManaged public var reps: [Int] //Reps of this exercise for each set
    @NSManaged public var rest: Int //Rest between sets of this exercise in seconds
    @NSManaged public var sets: Int
    @NSManaged public var weight: [Int] //Weight stored for this exercise for each set
    @NSManaged public var template: Bool //Flag indicating whether this is the template for an exercise or a logged one
    @NSManaged public var workout: Workout? //The workout that this exercise belongs to

}

extension Exercise : Identifiable {

}
