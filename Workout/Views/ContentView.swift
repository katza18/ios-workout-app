//
//  ContentView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationView {
            MainMenuView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
