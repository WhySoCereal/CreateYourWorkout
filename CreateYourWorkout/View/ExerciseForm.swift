//
//  ExerciseForm.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 08/10/2020.
//

import SwiftUI

struct ExerciseForm: View {
    @State var toggleExerciseRest: Bool = false
    @Binding var showingExerciseForm: Bool
    
    init(isPresented: Binding<Bool>) {
        _showingExerciseForm = isPresented
    }
    
    var body: some View {
        Form {
            VStack {
                List {
                    HStack {
                        Spacer()
                        Text("Exercise")
                        Spacer()
                        Toggle("", isOn: $toggleExerciseRest)
                        Spacer()
                        Text("Rest")
                        Spacer()
                    }
                    
                    if toggleExerciseRest {
                        Section {
                            Text("Exercise")
                        }
                    } else {
                        Section {
                            Text("Rest Period")
                        }
                    }
                }
                doneButton
            }
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
