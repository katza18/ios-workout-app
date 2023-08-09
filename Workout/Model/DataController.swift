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
        workout.id = UUID()
        workout.name = name
        workout.desc = desc
        workout.template = template
        workout.addToExercises(NSSet(array: exercises))
        
        save(context: context)
        
        return workout
    }
    
    //Use to add an exercise template
    func addExercise(name: String, sets: Int, reps: Int, rest: Int, template: Bool, context: NSManagedObjectContext) -> Exercise {
        //Create placeholder [Int]
        var repsArray: [Int] = []
        var weightArray: [Int] = []
        for _ in 1...sets {
            repsArray.append(reps)
            weightArray.append(0)
        }
        
        //Create exercise and store attributes
        let exercise = Exercise(context: context)
        exercise.name = name
        exercise.reps = repsArray
        exercise.rest = rest
        exercise.template = template
        exercise.weight = weightArray
        exercise.sets = sets
        exercise.id = UUID()
        
        //Save context
        save(context: context)
        
        //Return new exercise
        return exercise
    }
    
    //Used to log an exercise
    func addExercise(name: String, reps: [Int], rest: Int, template: Bool, weight: [Int], context: NSManagedObjectContext) -> Exercise {
        //Create exercise and store attributes
        let exercise = Exercise(context: context)
        exercise.name = name
        exercise.reps = reps
        exercise.rest = rest
        exercise.template = template
        exercise.weight = weight
        exercise.sets = exercise.weight.count
        exercise.id = UUID()
        
        //Save context
        save(context: context)
        
        //Return new exercise
        return exercise
    }
    
}
