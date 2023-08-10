//
//  WorkoutLogView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//


import SwiftUI

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
            List {
                //TODO: Fix the list to update correctly; reps length is incorrect.
                ForEach(loggedExercises, id: \.id) { exercise in
                    //Section for each new exercise
                    Section {
                        ForEach(exercise.loggedReps.indices, id: \.self) { index in
                            //For each set of the exercise, create a row
                            ExerciseLogTextView(weight: exercise.weight[index], reps: exercise.loggedReps[index])
                        }
                    } header: {
                        Text(exercise.name)
                    } //TODO: Add footer for plus/minus buttons
                }
            }
//            .listStyle(.plain)
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

