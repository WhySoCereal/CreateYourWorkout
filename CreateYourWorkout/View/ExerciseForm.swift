//
//  ExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 08/10/2020.
//

import SwiftUI

struct ExerciseForm: View {
    @Environment(\.managedObjectContext) var context
    @Binding private var workout: Workout
    @Binding private var showingExerciseForm: Bool
    
    init(isPresented: Binding<Bool>, workout: Binding<Workout>) {
        _showingExerciseForm = isPresented
        _workout = workout
    }
    
    @State private var choseExercise: Bool = true

    var body: some View {
        Form {
            Picker("Add to your workout:", selection: $choseExercise) {
                Text("Exercise").tag(true)
                Text("Rest").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
            
            if choseExercise {
                exerciseSection()
            } else {
                restSection()
            }
            doneButton
        }
    }
    
    private var doneButton: some View {
        Button("Save") {
            let exercise = Exercise(context: context)
            
            exercise.order = workout.exercises_?.count ?? 0
            
            if !exerciseName.isEmpty {
                exercise.name = exerciseName
            } else { return }

            if exerciseReps > 0 {
                exercise.reps = exerciseReps
            } else if timeInterval > 0 {
                exercise.time = timeInterval
            }
            
            workout.addToExercises_(exercise)
            try? context.save()
            
            showingExerciseForm = false
        }
    }
    
    @State private var repetitionsSelected: Bool = true
    @State private var exerciseName: String = ""
    @State private var exerciseReps: Int = 0
    @State private var timeInterval: Double = 0
    
    @ViewBuilder
    private func exerciseSection() -> some View {
        Section(header: Text("Exercise")) {
            TextField("Name:", text: $exerciseName)
            
            Picker("Repetitions or Timed", selection: $repetitionsSelected) {
                Text("Repetitions").tag(true)
                Text("Timed").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Group {
                if repetitionsSelected {
                    StepperField(title: "Repetitions:", value: $exerciseReps)
                } else {
                    TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
                }
            }.onAppear {
                exerciseReps = 0
                timeInterval = 0
            }
           
        }
    }
    
    @ViewBuilder
    private func restSection() -> some View {
        Section(header: Text("Rest Period")) {
            TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
        }
    }
}

//struct ExerciseForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseForm(isPresented: .constant(true))
//    }
//}
