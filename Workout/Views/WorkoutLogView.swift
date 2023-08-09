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
    @State private var newExercises: [Exercise] = []
    
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
                ForEach(loggedExercises.indices, id: \.self) { index in
                    //Section for each new exercise
                    Section {
                        ForEach(loggedExercises[index].reps.indices, id: \.self) { repIndex in
                            //For each set of the exercise, create a row
                            HStack {
                                Text("Weight")
                                TextField("\(oldExercises[index].weight[repIndex]) lbs", value: $loggedExercises[index].weight[repIndex], format: .number)
                                    .keyboardType(.numberPad)
                                Text("x")
                                TextField("\(oldExercises[index].reps[repIndex]) reps", value: $loggedExercises[index].reps[repIndex], format: .number)
                                    .keyboardType(.numberPad)
                            }
                        }
                    } header: {
                        Text(loggedExercises[index].name)
                    } //TODO: Add footer for plus/minus buttons
                }
            }
            .listStyle(.plain)
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
        .navigationTitle("Workout Name")
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
            let newExercise = DataController().addExercise(name: oldExercise.name, reps: oldExercise.reps, rest: oldExercise.rest, template: false, weight: oldExercise.weight, context: managedObjectContext)
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

