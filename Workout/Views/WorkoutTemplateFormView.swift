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
                let exercise = DataController().addExercise(name: "", sets: "", reps: "", rest: "", context: managedObjectContext)
                exercises.append(exercise)
            }
        }
    }
    
    var body: some View {
        ZStack {
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
                        ForEach($exercises, id: \.id) { exercise in
                            TextField("Exercise Name", text: exercise.name)
                            Section {
                                TextField("Sets", text: exercise.sets)
                                    .keyboardType(.numberPad)
                                TextField("Reps", text: exercise.reps)
                                    .keyboardType(.numberPad)
                                TextField("Rest", text: exercise.rest)
                                    .keyboardType(.numberPad)
                            }.padding(.leading, 30)
                        }
                    }
                }.foregroundColor(.black)
                HStack {
                    Spacer()
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.black)
                    Spacer()
                    Button("Submit"){
                        DataController().addWorkout(name: name, exercises: exercises, desc: desc, context: managedObjectContext)
                        
                        dismiss()
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .listRowBackground(Color.white)
//                }
//                .scrollContentBackground(.hidden)
            }
            .onAppear {
                exercises = []
            }
    }
    }
}

struct WorkoutTemplateFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTemplateFormView()
    }
}
