//
//  WorkoutTemplateRowView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI

struct WorkoutTemplateRowView: View {
    //var workout: Workout Template
    var workoutName: String
    var workoutDesc: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workoutName)
                .font(.title)
            HStack{
                Text(workoutDesc)
                    .font(.subheadline)
                Spacer()
            }
        }.padding()
    }
}

struct WorkoutTemplateRowView_Preview: PreviewProvider {
    static let sampleUUID = UUID()
    
    static var previews: some View {
        Group {
            WorkoutTemplateRowView(workoutName: "Workout Name", workoutDesc: "Workout Description")
        }
            .previewLayout(.fixed(width: 300, height: 30))
    }
}
