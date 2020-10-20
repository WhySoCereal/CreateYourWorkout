//
//  WorkoutView.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 06/10/2020.
//

import SwiftUI
import CoreData

enum ActiveSheet: String {
   case addExercise = "add", editExercise = "edit"
}

struct WorkoutView: View {
    @FetchRequest private var results: FetchedResults<Workout>
    @FetchRequest private var exercises: FetchedResults<Exercise>
    @Environment(\.managedObjectContext) private var context
    @State var editMode: EditMode = .inactive
    @State private var workout: Workout
    @State private var exercise: Exercise!
    
    init(_ workout: Workout) {
        _workout = State(wrappedValue: workout)
        _results = FetchRequest(fetchRequest: Workout.fetchWorkout(workout: workout))
        _exercises = FetchRequest(fetchRequest: Exercise.fetchWorkoutExercises(forWorkout: workout.id))
    }
    
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet!
    
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                ExerciseRow(exercise: exercise)
                    .onTapGesture {
                        activeSheet = .editExercise
                        self.exercise = exercise
                        showSheet = true
                    }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
        .navigationTitle(workout.name)
        .navigationBarItems(leading: EditButton(), trailing: addExerciseButton)
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $showSheet) {
            if activeSheet == .addExercise {
                AddExerciseForm(isPresented: $showSheet, workout: $workout)
                    .environment(\.managedObjectContext, context)
            } else {
                EditExerciseForm(isPresented: $showSheet, exercise: $exercise)
                    .environment(\.managedObjectContext, context)
            }
        }
    }
    
    private var addExerciseButton: some View {
        Button(action: {
            activeSheet = .addExercise
            showSheet = true
        }, label: {
            Image(systemName: "plus")
        })
    }

    private func onMove(item: IndexSet, newPosition: Int) {
        var offsets = Array<Int>(0..<exercises.count)
        offsets.move(fromOffsets: item, toOffset: newPosition)

        var count = 0
        for offset in offsets {
            exercises[offset].order = count
            count += 1
        }

        try? context.save()
    }
    
    private func onDelete(item: IndexSet) {
        context.delete(exercises[item.first!])
        // re-establish order after deletion
        try? context.save()
    }
    
}


