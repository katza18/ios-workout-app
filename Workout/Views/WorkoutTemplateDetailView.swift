//
//  WorkoutTemplateDetailView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI

struct WorkoutTemplateDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var workoutName: String?
    @State var workoutDesc: String?
    @State var exercises: [Exercise]?
    
    var body: some View {
        VStack {
            Text(workoutName ?? "Error loading name.")
                .font(.largeTitle)
            Spacer()
//            Text("Description")
//                .multilineTextAlignment(.center)
//                .font(.headline)
            Text(workoutDesc ?? "Sample description.")
                .font(.subheadline)
            Spacer()
            List {
                Section {
                    ForEach(exercises ?? [], id: \.self) { exercise in
                        HStack {
                            Text("\(exercise.name)")
                            Spacer()
                            Text("\(exercise.sets) x \(exercise.reps)")
                        }
                    }
                } header: {
                    Text("Exercises")
                }
            }
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    WorkoutLogView(exercises: exercises ?? [])
                } label: {
                    Text("Start")
                }
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

struct WorkoutTemplateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateDetailView()
    }
}

