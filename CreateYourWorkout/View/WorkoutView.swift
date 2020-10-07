//
//  WorkoutView.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 06/10/2020.
//

import SwiftUI
import CoreData

struct WorkoutView: View {
    @Environment(\.managedObjectContext) var context
    var workout: Workout
    
    init(_ workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workout.exercises.sorted()) { exercise in
                    
                }
            }
        }
        .navigationTitle(workout.name)
        .navigationBarItems(trailing: addExerciseButton)
    }
    
    @State var showingExerciseForm: Bool = false
    
    private var addExerciseButton: some View {
        Button(action: {
            print("add pressed")
            showingExerciseForm = true
        }, label: {
            Image(systemName: "plus")
        }).sheet(isPresented: $showingExerciseForm) {
            ExerciseForm(isPresented: $showingExerciseForm)
        }
    }
}


