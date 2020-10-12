//
//  WorkoutView.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 06/10/2020.
//

import SwiftUI
import CoreData

struct WorkoutView: View {
    @FetchRequest private var results: FetchedResults<Workout>
    @Environment(\.managedObjectContext) private var context
    @State private var editMode: EditMode = .inactive
    @State private var workout: Workout
    
    init(_ workout: Workout) {
        _workout = State(wrappedValue: workout)
        _results = FetchRequest(fetchRequest: Workout.fetchWorkout(workout: workout))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workout.exercises) { exercise in
                    Text(exercise.name)
                }
                .onDelete { item in
                    context.delete(workout.exercises[item.first!])
                    try? context.save()
                }
                .onMove { (item, newPosition) in
                    print("\(newPosition)")
                    print(workout.exercises[item.first!])
                    
                    // TODO: Order the exercises - NSOrderedSet maybe?
                }
            }
        }
        .navigationTitle(workout.name)
        .navigationBarItems(leading: EditButton(), trailing: addExerciseButton)
        .sheet(isPresented: $showingExerciseForm) {
            ExerciseForm(isPresented: $showingExerciseForm, workout: $workout)
                .environment(\.managedObjectContext, context)
        }
        .environment(\.editMode, $editMode)
    }
    
    @State var showingExerciseForm: Bool = false
    
    private var addExerciseButton: some View {
        Button(action: {
            showingExerciseForm = true
        }, label: {
            Image(systemName: "plus")
        })
    }
}


