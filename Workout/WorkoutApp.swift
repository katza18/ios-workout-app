//
//  WorkoutApp.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI

@main
struct WorkoutApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
