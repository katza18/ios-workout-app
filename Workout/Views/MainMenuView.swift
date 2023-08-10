//
//  MainMenuView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI
import CoreData

struct MainMenuView: View {
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.name, ascending: true)],
        predicate: NSPredicate(format: "template == %@", NSNumber(value: true))
    ) var templateWorkouts: FetchedResults<Workout>
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: true)],
        predicate: NSPredicate(format: "template == %@", NSNumber(value: false))
    ) var loggedWorkouts: FetchedResults<Workout>
    
    @State private var showPopover: Bool = false
    @State private var showTemplates: Bool = true
    
    var body: some View {
        //TODO: ADD BUTTONS FOR SELECTING LIST TO VIEW
        List {
            Section{
                if showTemplates {
                    WorkoutListView(workouts: templateWorkouts)
                } else {
                    WorkoutListView(workouts: loggedWorkouts)
                }
            } header: {
                VStack {
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
                    HStack {
                        Button("Up Next") {
                            showTemplates = true
                        }
                        Spacer()
                        Button("Past") {
                            showTemplates = false
                        }
                    }
                }
            }
        }
//        .scrollContentBackground(.hidden)
    }
}



struct WorkoutTemplateListView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
