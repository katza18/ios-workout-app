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
    
    var body: some View {
        //Unpack exercises array, originally an NSSet
        let exercises = workout?.exercises?.array as? [Exercise]
            
        VStack {
            //Workout Name Header
            Text(workout?.name ?? "Error loading name.")
                .font(.largeTitle)
            Spacer()
            
            if(!(workout?.template ?? true)) {
                Text(workout?.date ?? Date(), format: .dateTime.day().month().year())
            }
            
            //Workout description text
            Text(workout?.desc ?? "Sample description.")
                .font(.subheadline)
            Spacer()
            
            //List of exercises
            List {
                //Section for exercises with header "exercises"
                Section {
                    //Line for each exercise and details
                    if workout?.template ?? true {
                        ForEach(exercises ?? []) { exercise in
                            HStack {
                                Text("\(exercise.name)")
                                Spacer()
                                Text("\(exercise.sets) x \(exercise.expectedReps)")
                            }
                        }
                    } else {
                        ForEach(exercises ?? []) { exercise in
                            Text("\(exercise.name)")
                            Section {
                                ForEach(exercise.weight.indices, id: \.self) { index in
                                    Text("\(exercise.weight[index]) lbs x \(exercise.loggedReps[index]) reps RPE \(exercise.intensity[index])")
                                }
                            }.padding(.leading, 30)
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
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden()
    }
}

struct WorkoutTemplateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateDetailView()
    }
}

