//
//  DataController.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
        } catch {
            print("Could not save data. Error: \(error)")
        }
    }
    
    func delete(context: NSManagedObjectContext, workout: Workout) {
        context.delete(workout)
        
        try? context.save()
    }
    
    func addWorkout(name: String, exercises: [Exercise], desc: String, context: NSManagedObjectContext) {
        let workout = Workout(context: context)
        workout.id = UUID()
        workout.name = name
        workout.desc = desc
        workout.addToExercises(NSSet(array: exercises))
        
        save(context: context)
    }
    
    func addExercise(name: String, sets: String, reps: String, rest: String, context: NSManagedObjectContext) -> Exercise {
        let exercise = Exercise(context: context)
        exercise.name = name
        exercise.sets = sets
        exercise.reps = reps
        exercise.rest = rest
        exercise.id = UUID()
        
        save(context: context)
        
        return exercise
    }
    
}
