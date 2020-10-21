//
//  ExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 08/10/2020.
//

import SwiftUI

struct AddExerciseForm: View {
    @Environment(\.managedObjectContext) var context
    @Binding private var workout: Workout
    @Binding private var activeSheet: ActiveSheet?
    @State private var repetitionsSelected: Bool = true
    @State private var exerciseName: String = ""
    @State private var exerciseReps: Int = 1
    @State private var timeInterval: Double = 0
    
    
    init(isActive: Binding<ActiveSheet?>, workout: Binding<Workout>) {
        _activeSheet = isActive
        _workout = workout
    }

    @State private var choseExercise: Bool = true
    @State private var title: String = "Add Exercise"

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.title)
                .padding([.top, .leading], 20)
            Form {
                Section(header: Text("Type")) {
                    Picker("Add to your workout:", selection: $choseExercise) {
                        Text("Exercise").tag(true)
                        Text("Rest").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                if choseExercise {
                    exerciseSection()
                        .onAppear {
                            title = "Add Exercise"
                        }
                } else {
                    restSection()
                        .onAppear {
                            title = "Add Rest"
                        }
                }
            }
        }
    }
        
    // MARK: - Exercise Section
    
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
            let exercise = Exercise(context: context)
            
            exercise.order = workout.exercises_?.count ?? 0
            
            if choseExercise {
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
                
                activeSheet = nil
            } else {
                // TODO: else case here
            }
        }
    }
    
    // MARK: - Rest Section
    
    @ViewBuilder
    private func restSection() -> some View {
        Section(header: Text("Rest")) {
            TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
        }
        
        HStack {
            Spacer()
            cancelButton.background(Rectangle().foregroundColor(.blue))
            Spacer()
            Divider()
            Spacer()
            restSaveButton.background(Rectangle().foregroundColor(.red))
            Spacer()
        }
    }
    
    private var restSaveButton: some View {
        Button("Save") {
            if timeInterval == 0 {
                // TODO: alert for user to enter a valid time
            }
            
            let exercise = Exercise(context: context)
            exercise.name = "Rest"
            exercise.order = workout.exercises_?.count ?? 0
            exercise.time = timeInterval
            
            workout.addToExercises_(exercise)
            try? context.save()
            
            activeSheet = nil
        }
    }
    
    // MARK: - Utility
    private var cancelButton: some View {
        Button("Cancel") {
            activeSheet = nil
        }
    }
}

//struct ExerciseForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseForm(isPresented: .constant(true))
//    }
//}
