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
    
    func addWorkout(name: String, exercises: [Exercise], desc: String, template: Bool, context: NSManagedObjectContext) -> Workout {
        let workout = Workout(context: context)
        if (!template) { workout.date = Date() }
        
        workout.id = UUID()
        workout.name = name
        workout.desc = desc
        workout.template = template
        workout.addToExercises(NSMutableOrderedSet(array: exercises))
        
        save(context: context)
        
        return workout
    }
    
    //Use to add an exercise template
    func addExercise(name: String, sets: String, expectedReps: String, rest: String, template: Bool, context: NSManagedObjectContext) -> Exercise {
        //Create exercise and store attributes
        let exercise = Exercise(context: context)
        
        //Create correct arrays if not a template
        var newArray: [String] = []
        if (!template) {
            newArray = [String](repeating: "", count: Int(sets) ?? 1)
            exercise.loggedReps = newArray
            exercise.weight = newArray
        } else {
            exercise.loggedReps = [""]
            exercise.weight = [""]
        }
        
        exercise.name = name
        exercise.expectedReps = expectedReps
        exercise.rest = rest
        exercise.template = template
        exercise.sets = sets
        exercise.id = UUID()
        
        //Save context
        save(context: context)
        
        //Return new exercise
        return exercise
    }
}
