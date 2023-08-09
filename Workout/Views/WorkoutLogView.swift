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
    @State var oldExercises: [Exercise]?
    @State private var loggedExercises: [Exercise] = []
    @State private var newExercises: [Exercise] = []
    
    var body: some View {
        
        var newWorkout = DataController().addWorkout(name: workout?.name ?? "", exercises: [], desc: workout?.desc ?? "", template: false, context: managedObjectContext)
        
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
                
            }
            .listStyle(.plain)
            HStack {
                Spacer()
                Button("Done") {
                    //Add exercises array to workout and save context
//                    workout.exercises = loggedExercises
//                    DataController().save(context: managedObjectContext)
                    
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
//            ForEach(oldExercises ?? []) { exercise in
//                let sets = Int(exercise.sets)
//
//                ForEach(0..<(sets ?? 1), id: \.self) { _ in
//                    let newExercise = DataController().addExercise(name: exercise.name, sets: "1", reps: exercise.reps, rest: exercise.rest, template: false, weight: exercise.weight, context: managedObjectContext)
//                    let _ = newExercises.append(newExercise)
//                }
//            }
        }
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView()
    }
}

