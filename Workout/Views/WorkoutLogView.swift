//
//  WorkoutLogView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//


import SwiftUI
import CoreData
import Foundation

struct WorkoutLogView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var workout: Workout?
    @State var oldExercises: [Exercise]
    @State private var loggedExercises: [Exercise] = []
    @State private var showingDoneAlert = false
    @State private var showingCancelAlert = false
    @StateObject private var timer = WorkoutTimer()
    @StateObject private var stopwatch = WorkoutTimer()
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            Text("Timer: \(timer.formattedTime)")
                .font(.subheadline)
            //List of exercises
            List {
                ForEach(loggedExercises.indices, id: \.self) { exerciseIndex in
                    Section {
                        ForEach(loggedExercises[exerciseIndex].weight.indices, id: \.self) { index in
                            let weightBinding = Binding(get: { loggedExercises[exerciseIndex].weight[index] }, set: { newValue in
                                loggedExercises[exerciseIndex].weight[index] = newValue
                                oldExercises[exerciseIndex].weight[0] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            let repsBinding = Binding(get: { loggedExercises[exerciseIndex].loggedReps[index] }, set: { newValue in
                                loggedExercises[exerciseIndex].loggedReps[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            let intensityBinding = Binding(get: { loggedExercises[exerciseIndex].intensity[index] }, set: { newValue in
                                loggedExercises[exerciseIndex].intensity[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            
                            HStack {
                                TextField("\(oldExercises[exerciseIndex].weight[0])", text: weightBinding)
                                Text("lbs x")
                                TextField("\(loggedExercises[exerciseIndex].expectedReps)", text: repsBinding)
                                Text("reps")
                                Text(" RPE")
                                TextField("\(loggedExercises[exerciseIndex].intensity[index])", text: intensityBinding)
                            }
                            .focused($isFocused)
                            .listRowSeparator(.hidden)
                        }
                    } header: {
                        Text(loggedExercises[exerciseIndex].name)
                    } //TODO: Add footer for plus/minus buttons
                }
            }
            HStack {
                Text("Stop Watch: \(stopwatch.formattedTime)")
                if stopwatch.isRunning {
                    Button("Stop") {
                        stopwatch.pause()
                    }
                } else {
                    Button("Start") {
                        stopwatch.start()
                    }
                    Button("Reset") {
                        stopwatch.stop()
                    }
                }
            }
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    //hide keyboard and show alert
                    isFocused = false
                    showingDoneAlert = true
                }
                Spacer()
                Button("Cancel") {
                    isFocused = false
                    showingCancelAlert = true
                }
                Spacer()
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(workout?.name ?? "Error loading name.")
        .alert("Finish Workout", isPresented: $showingDoneAlert, actions: {
            VStack {
                Button("Done") {
                    //Create the new workout log, this will also save changes to the new exercises
                    let _ = DataController().addWorkout(name: workout?.name ?? "", exercises: loggedExercises, desc: workout?.desc ?? "", template: false, context: managedObjectContext)
                    
                    //Stop timer
                    timer.stop()
                    stopwatch.stop()
                    
                    //Dismiss the view
                    dismiss()
                }
                Button("Cancel", role: .cancel){}
            }
        }, message: { Text("Are you done working out?") })
        .alert("Delete Workout", isPresented: $showingCancelAlert, actions: {
            VStack {
                Button("Delete", role: .destructive){
                    timer.stop()
                    stopwatch.stop()
                    dismiss()
                }
                Button("Cancel", role: .cancel){}
            }
        }, message: { Text("Do you want to delete this workout?") })
        .onAppear {
            //Create the logged exercises when the view renders
            loggedExercises = createLoggedExercises()
            
            //Start workout timer
            timer.start()
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

