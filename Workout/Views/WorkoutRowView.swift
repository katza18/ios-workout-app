//
//  WorkoutTemplateRowView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI

struct WorkoutTemplateRowView: View {
    @State var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.name ?? "Error loading name.")
                .font(.title)
            if !workout.template {
                Text(workout.date ?? Date(), format: .dateTime.day().month().year())
            } else {
                HStack{
                    Text(workout.desc ?? "Error loading description.")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }.padding()
    }
}

//struct WorkoutTemplateRowView_Preview: PreviewProvider {
//    static let sampleUUID = UUID()
//
//    static var previews: some View {
//        Group {
//            WorkoutTemplateRowView(workoutName: "Workout Name", workoutDesc: "Workout Description")
//        }
//            .previewLayout(.fixed(width: 300, height: 30))
//    }
//}
