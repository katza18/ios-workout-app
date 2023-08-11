//
//  WorkoutTemplateFormView.swift
//  Workout
//
//  Created by Aidan Katz on 8/2/23.
//

import SwiftUI
import CoreData

struct WorkoutTemplateFormView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var exercises: [Exercise] = []
    
    var body: some View {
        VStack{
            Text("Create Workout")
                .font(.largeTitle)
            Spacer()
            List {
                Section(header: Text("Workout Name")) {
                    TextField("", text: $name)
                }
                Section(header: Text("Workout Description (Optional)")) {
                    TextField("", text: $desc)
                }
                Section(header: Text("Exercises"), footer: addExerciseButton) {
                    ForEach(exercises.indices, id: \.self) { index in
                        Group {
                            TextField("Exercise Name", text: $exercises[index].name)
                        }
                        Section {
                            HStack {
                                TextField("Sets", text: $exercises[index].sets)
                            }
                            HStack {
                                TextField("Reps", text: $exercises[index].expectedReps)
                            }
                            HStack {
                                TextField("Rest", text: $exercises[index].rest)
                            }
                        }.padding(.leading, 30)
                    }
                }
            }
            HStack {
                Spacer()
                Button("Cancel"){
                    dismiss()
                }
//                .foregroundColor(.black)
                Spacer()
                Button("Submit"){
                    //THIS SAVES CONTEXT FOR EXERCISES TOO
                    let _ = DataController().addWorkout(name: name, exercises: exercises, desc: desc, template: true, context: managedObjectContext)
                    
                    dismiss()
                }
//                .foregroundColor(.black)
                Spacer()
            }
//            .listRowBackground(Color.white)
        }
        
    }
    
    var addExerciseButton: some View {
        HStack {
            if (exercises.count > 0) {
                HStack {
                    Image(systemName: "minus")
                    Text("Exercise")
                }.onTapGesture {
                    exercises.removeLast()
                }
            }
            Spacer()
            HStack {
                Image(systemName: "plus")
                Text("Exercise")
            }
            .onTapGesture {
                //Add empty exercise to exercises
                let exercise = DataController().addExercise(name: "", sets: "", expectedReps: "", rest: "", template: true, context: managedObjectContext)
                exercises.append(exercise)
            }
        }
    }
}

struct WorkoutTemplateFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateFormView()
            .colorScheme(.light)
    }
}
