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
    @State private var showingDoneAlert = false
    @State private var showingCancelAlert = false
    
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
                ForEach($loggedExercises) { $exercise in
                    Section {
                        ForEach(exercise.weight.indices, id: \.self) { index in
                            let weightBinding = Binding(get: { exercise.weight[index] }, set: { newValue in
                                exercise.weight[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            let repsBinding = Binding(get: { exercise.loggedReps[index] }, set: { newValue in
                                exercise.loggedReps[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            let intensityBinding = Binding(get: { exercise.intensity[index] }, set: { newValue in
                                exercise.intensity[index] = newValue
                                DataController().save(context: managedObjectContext)
                            })
                            
                            HStack {
                                TextField("\(exercise.weight[index])", text: weightBinding)
                                Text("lbs x")
                                TextField("\(exercise.expectedReps)", text: repsBinding)
                                Text("reps")
                                Text(" RPE")
                                TextField("\(exercise.intensity[index])", text: intensityBinding)
                            }
                            .listRowSeparator(.hidden)
                        }
                    } header: {
                        Text(exercise.name)
                    } //TODO: Add footer for plus/minus buttons
                }
            }
            HStack {
                Spacer()
                Button("Done") {
                    //hide keyboard and show alert
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
                    showingDoneAlert = true
                }
                Spacer()
                Button("Cancel") {
                    //hide keyboard
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
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
                    
                    //Dismiss the view
                    dismiss()
                }
                Button("Cancel", role: .cancel){}
            }
        }, message: { Text("Are you done working out?") })
        .alert("Delete Workout", isPresented: $showingCancelAlert, actions: {
            VStack {
                Button("Delete", role: .destructive){
                    dismiss()
                }
                Button("Cancel", role: .cancel){}
            }
        }, message: { Text("Do you want to delete this workout?") })
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

