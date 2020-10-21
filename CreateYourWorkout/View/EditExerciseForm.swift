//
//  EditExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 18/10/2020.
//

import SwiftUI

struct EditExerciseForm: View {
    @Environment(\.managedObjectContext) var context
    @Binding private var exercise: Exercise!
    @Binding private var activeSheet: ActiveSheet?
    @State private var exerciseName: String = ""
    @State private var repetitionsSelected: Bool = true
    @State private var exerciseReps: Int = 1
    @State private var timeInterval: TimeInterval = 0
    
    var title: String {
        exercise.name == "Rest" ? "Edit Rest Period" : "Edit Exercise"
    }
    
    init(isActive: Binding<ActiveSheet?>, exercise: Binding<Exercise?>) {
        _activeSheet = isActive
        _exercise = exercise
    }
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.title)
                .padding([.top, .leading], 20)
            Form {
                if exercise.name == "Rest" {
                    editRest()
                } else {
                    editExercise()
                }
            }
            .onAppear {
                exerciseName = exercise.name
                repetitionsSelected = exercise.reps > 0
                timeInterval = exercise.time
                exerciseReps = exercise.reps
            }
        }
    }
    
    // MARK: - Edit Exercise Section
    @ViewBuilder
    private func editExercise() -> some View {
        Section(header: Text("Exercise")) {
            HStack {
                Text("Name:")
                Divider()
                TextField("Name:", text: $exerciseName)
            }
            
            Picker("Repetitions or Timed", selection: $repetitionsSelected) {
                Text("Repetitions").tag(true)
                Text("Timed").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if repetitionsSelected {
                StepperField(title: "Repetitions:", value: $exerciseReps)
            } else {
                TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
            }
        }
        
        HStack {
            Spacer()
            cancelButton
            Spacer()
            Divider()
            Spacer()
            exerciseSaveButton
            Spacer()
        }
    }
    
    private var exerciseSaveButton: some View {
        Button("Save") {
            print("save")
            exercise.name = exerciseName
            
            if repetitionsSelected {
                exercise.reps = exerciseReps
                exercise.time = 0
            } else {
                exercise.reps = 0
                exercise.time = timeInterval
            }
            
            do {
                try context.save()
            } catch {
                print("error")
            }
            
            activeSheet = nil
            
        }
    }
    
    // MARK: - Edit Rest Section
    
    @ViewBuilder
    private func editRest() -> some View {
        Section(header: Text("Rest")) {
            TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
        }
        
        HStack {
            Spacer()
            cancelButton
            Spacer()
            Divider()
            Spacer()
            restSaveButton
            Spacer()
        }
    }
    
    private var restSaveButton : some View {
        Button("Save") {
            if timeInterval == 0 {
                // TODO: error
            } else {
                exercise.time = timeInterval
                try? context.save()
                activeSheet = nil
            }
        }
    }
    
    // MARK: - Utility
    private var cancelButton: some View {
        Button("Cancel") {
            activeSheet = nil
        }
    }
}

