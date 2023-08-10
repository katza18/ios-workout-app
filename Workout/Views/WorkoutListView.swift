//
//  WorkoutTemplateListView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI
import CoreData

struct WorkoutTemplateListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Workout.name, ascending: true)]) var workouts: FetchedResults<Workout>
    @State private var showPopover: Bool = false
    
    var body: some View {
        List {
            Section{
                ForEach(workouts, id: \.id) { workout in
                    NavigationLink {
                        WorkoutTemplateDetailView(workout: workout)
                    } label: {
                        WorkoutTemplateRowView(workoutName: workout.name ?? "Error loading workout name.", workoutDesc: workout.desc ?? "Error loading workout description")
                    }
                }
                .onDelete { indices in
                    deleteWorkout(at: indices)
                }
            } header: {
                HStack {
                    Text("Main Menu")
                        .font(.largeTitle)
                    .foregroundColor(.black)
                    Spacer()
                    Button {
                        showPopover = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.blue)
                            .clipShape(Circle())
                            
                    }
                    .fullScreenCover(isPresented: $showPopover) {
                        WorkoutTemplateFormView()
                    }
                }
            }
        }
//        .scrollContentBackground(.hidden)
    }
    
    private func deleteWorkout(at indices: IndexSet) {
        for index in indices {
            let workout = workouts[index]
            DataController().delete(context: managedObjectContext, workout: workout)
        }
    }
}



struct WorkoutTemplateListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateListView()
    }
}
