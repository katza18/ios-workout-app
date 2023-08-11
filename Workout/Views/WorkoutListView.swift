//
//  WorkoutListView.swift
//  Workout
//
//  Created by Aidan Katz on 8/10/23.
//

import SwiftUI

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest var workouts: FetchedResults<Workout>
    
    init(template: Bool) {
            let predicate = NSPredicate(format: "template == %@", NSNumber(value: template))
            _workouts = FetchRequest(entity: Workout.entity(),
                                     sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: true)],
                                     predicate: predicate)
        }
    
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
            DataController().delete(context: managedObjectContext, workout: workouts[index])
        }
    }
}

//struct WorkoutListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutListView()
//    }
//}
