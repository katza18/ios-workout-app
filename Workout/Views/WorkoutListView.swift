//
//  WorkoutListView.swift
//  Workout
//
//  Created by Aidan Katz on 8/10/23.
//

import SwiftUI

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var workouts: FetchedResults<Workout>
    
    var body: some View {
        ForEach(workouts) { workout in
            NavigationLink {
                WorkoutTemplateDetailView(workout: workout)
            } label: {
                WorkoutTemplateRowView(workout: workout)
            }
        }
        .onDelete { indices in
            deleteWorkout(at: indices)
        }
    }
    
    private func deleteWorkout(at indices: IndexSet) {
        for index in indices {
            let workout = workouts[index]
            DataController().delete(context: managedObjectContext, workout: workout)
        }
    }
}

//struct WorkoutListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutListView()
//    }
//}
