//
//  WorkoutTemplateDetailView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI

struct WorkoutTemplateDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var workout: Workout?
    @State var exercises: [Exercise]?
    
    var body: some View {
        //Unpack exercises array, originally an NSSet
        let exercises = workout?.exercises?.allObjects as? [Exercise]
        
        VStack {
            //Workout Name Header
            Text(workout?.name ?? "Error loading name.")
                .font(.largeTitle)
            Spacer()
//            Text("Description")
//                .multilineTextAlignment(.center)
//                .font(.headline)
            
            //Workout description text
            Text(workout?.desc ?? "Sample description.")
                .font(.subheadline)
            Spacer()
            
            //List of exercises
            List {
                //Section for exercises with header "exercises"
                Section {
                    //Line for each exercise and details
                    ForEach(exercises ?? [], id: \.self) { exercise in
                        HStack {
                            Text("\(exercise.name)")
                            Spacer()
                            Text("\(exercise.sets) x \(exercise.reps[0])")
                        }
                    }
                } header: {
                    Text("Exercises")
                }
            }
            Spacer()
            
            //End screen buttons
            HStack {
                Spacer()
                NavigationLink {
                    WorkoutLogView(workout: workout, oldExercises: exercises ?? [])
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

