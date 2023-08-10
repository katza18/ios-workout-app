//
//  SwiftUIView.swift
//  Workout
//
//  Created by Aidan Katz on 8/9/23.
//

import SwiftUI

struct ExerciseLogTextView: View {
    @State var weight: String
    @State var reps: String
    
    var body: some View {
        HStack {
            TextField("100", text: $weight).multilineTextAlignment(.center)
            Text("lbs x")
            TextField("6", text: $reps).multilineTextAlignment(.center)
            Text("reps")
        }.listRowSeparator(.hidden)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseLogTextView(weight: "135", reps: "4")
    }
}
