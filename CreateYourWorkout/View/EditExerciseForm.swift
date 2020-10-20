//
//  EditExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 18/10/2020.
//

import SwiftUI

struct EditExerciseForm: View {
    @Environment(\.managedObjectContext) var context
    @Binding private var exercise: Exercise?
    @Binding private var showingEditExercise: Bool
    
    var title: String {
        exercise?.name == "Rest" ? "Edit Rest Period" : "Edit Exercise"
    }
    
    init(isPresented: Binding<Bool>, exercise: Binding<Exercise?>) {
        _showingEditExercise = isPresented
        _exercise = exercise
    }
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.title)
                .padding([.top, .leading], 20)
            Form {
                if exercise?.name == "Rest" {
                    editRest()
                } else {
                    editExercise()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        showingEditExercise = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    Button(action: {
                        exercise?.name = exerciseName
                        
                        if repetitionsSelected {
                            exercise?.reps = exerciseReps
                            exercise?.time = 0
                        } else {
                            exercise?.reps = 0
                            exercise?.time = timeInterval
                        }
                        
                        try? context.save()
                        showingEditExercise = false
                    }, label: {
                        Text("Save")
                    })
                    Spacer()
                }
            }
            .onAppear {
                exerciseName = exercise?.name ?? ""
                repetitionsSelected = exercise?.reps ?? 1 > 0 ? true : false
                timeInterval = exercise?.time ?? 0
                exerciseReps = exercise?.reps ?? 0
            }
        }
    }
    
    @State private var exerciseName: String = ""
    @State private var repetitionsSelected: Bool = true
    @State private var exerciseReps: Int = 1
    @State private var timeInterval: TimeInterval = 0
    
    @ViewBuilder
    private func editRest() -> some View {
        
    }
    
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
    }
}
