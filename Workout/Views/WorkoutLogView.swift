//
//  WorkoutLogView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//


import SwiftUI
import CoreData

struct WorkoutLogView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var workout: Workout?
    @State var oldExercises: [Exercise]
    @State private var loggedExercises: [Exercise] = []
    
    var body: some View {
        VStack {
            Text("Timer: 0:00")
                .font(.subheadline)
            HStack {
                Text("Stop Watch: 0:00")
                Button("Start") {
                    
                }
                Button("Stop") {
                    
                }
            }
            //List of exercises
            List {
                ForEach($loggedExercises, id: \.id) { $exercise in
                    Section {
                        ForEach(exercise.weight.indices) { index in
                            let weightBinding = Binding(get: { exercise.weight[index] }, set: { newValue in
                                exercise.weight[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            let repsBinding = Binding(get: { exercise.loggedReps[index] }, set: { newValue in
                                exercise.loggedReps[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            
                            HStack {
                                TextField("\(exercise.weight[index])", text: weightBinding)
                                Text("lbs x")
                                TextField("\(exercise.expectedReps)", text: repsBinding)
                                Text("reps")
                            }.listRowSeparator(.hidden)
                        }
                    } header: {
                        Text(exercise.name)
                    } //TODO: Add footer for plus/minus buttons
                }
            }
            HStack {
                Spacer()
                Button("Done") {
                    //Create the new workout log, this will also save changes to the new exercises
                    let _ = DataController().addWorkout(name: workout?.name ?? "", exercises: loggedExercises, desc: workout?.desc ?? "", template: false, context: managedObjectContext)
                    
                    //Dismiss the view
                    dismiss()
                }
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
            }
            Spacer()
        }
        .navigationTitle(workout?.name ?? "Error loading name.")
        .navigationBarBackButtonHidden()
        .onAppear {
            //Create the logged exercises when the view renders
            loggedExercises = createLoggedExercises()
        }
    }
    
    private func createLoggedExercises() -> [Exercise] {
        //Create a new array of exercises
        var newExercises : [Exercise] = []
        
        for oldExercise in oldExercises {
            //Create newExercise from template and add to array
            let newExercise = DataController().addExercise(name: oldExercise.name, sets: oldExercise.sets, expectedReps: oldExercise.expectedReps, rest: oldExercise.rest, template: false, context: managedObjectContext)
            newExercises.append(newExercise)
        }
        
        //Return the new array
        return newExercises
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView(oldExercises: [])
    }
}

