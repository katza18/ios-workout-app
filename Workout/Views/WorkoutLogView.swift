//
//  WorkoutLogView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//


import SwiftUI

struct WorkoutLogView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var exercises: [Exercise]?
    @State private var newExerciseWeight: String = ""
    @State private var newExerciseReps: String = ""
    
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
                ForEach(exercises ?? []) { exercise in
                    let sets = Int(exercise.sets)
                    Section {
                        ForEach(0..<(sets ?? 1), id: \.self) { _ in
                            HStack {
                                TextField("100 lbs", text: $newExerciseWeight)
                                Spacer()
                                Text(" x ")
                                Spacer()
                                TextField("\(exercise.reps)", text: $newExerciseReps)
                            }
                        }
                        .listRowSeparator(.hidden, edges: .bottom)
                    } header: {
                        Text(exercise.name)
                    }
                }
            }
            .listStyle(.plain)
            HStack {
                Spacer()
                Button("Done") {
                    //Save workout
                    //dismiss()
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
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView()
    }
}

