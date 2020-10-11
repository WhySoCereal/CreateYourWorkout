//
//  ExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 08/10/2020.
//

import SwiftUI



struct ExerciseForm: View {
    @Binding var showingExerciseForm: Bool
    @State var exerciseName: String = ""
    @State var exerciseReps: Int = 0
    @State var timeInterval: Double = 0
    
    @State var exerciseTime: Int = 0
    @State var date: Date = Date()
    
    init(isPresented: Binding<Bool>) {
        _showingExerciseForm = isPresented
    }
    
    @State var choseExercise: Bool = true

    var body: some View {
        Form {
            Picker("Add to your workout:", selection: $choseExercise) {
                Text("Exercise").tag(true)
                Text("Rest").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
            
            if choseExercise {
                Section(header: Text("Exercise")) {
                    
                    // MARK: - Exercise selected

                    TextField("Name:", text: $exerciseName)
                    
                    // Select the number of repetitions for the exercise
                    StepperField(title: "Repetitions:", value: $exerciseReps)

                    // TIME INTERVAL
                    TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
                }
            } else {
                Section(header: Text("Rest Period")) {
                    // MARK: - Rest selected

                    // TIME INTERVAL
                    TimeIntervalPicker(title: "Time Interval:", value: $timeInterval)
                }
            }
            doneButton
        }
    }
    
    private var doneButton: some View {
        Button("Add") {
            print("added exercise")
            showingExerciseForm = false
        }
    }
}

//struct ExerciseForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseForm()
//    }
//}
