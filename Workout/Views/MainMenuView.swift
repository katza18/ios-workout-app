//
//  MainMenuView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI
import CoreData

struct MainMenuView: View {
    @State private var showTemplates: Bool = true
    
    var body: some View {
        List {
            Section{
                if showTemplates {
                    WorkoutListView(template: true)
                } else {
                    WorkoutListView(template: false)
                }
            } header: {
                VStack {
                    HStack {
                        Text("Workouts")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        Spacer()
                        NavigationLink {
                            WorkoutTemplateFormView()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.blue)
                                .clipShape(Circle())
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
