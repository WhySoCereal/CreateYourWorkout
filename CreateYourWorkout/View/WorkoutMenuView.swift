//
//  ContentView.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//

import SwiftUI

struct WorkoutMenuView: View {
    @ObservedObject var workoutVM: WorkoutVM
    
    var workouts: [Workout] {
        workoutVM.workouts
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    Text("\(workout.name!)")
                }
            }
            .navigationTitle(Text("Workouts"))
            .navigationBarItems(trailing: addWorkoutButton)
        }
        .textFieldAlert(isPresented: $addWorkoutShow, placeholderText: "Name of workout", text: $newWorkoutName, title: "New Workout")
    }
    
    @State private var addWorkoutShow = false
    @State private var newWorkoutName = ""
    
    private var addWorkoutButton: some View {
        Button(action: {
            // TODO: Add workout button
            addWorkoutShow = true
            
            print("opened")
        }, label: {
            Image(systemName: "plus")
        })
        .disabled(addWorkoutShow)
    }
    
    private var editWorkoutButton: some View {
        Button(action: {
        // TODO: Edit workout button
            print("editing")
        }, label: {
            Text("Edit")
        })
    }
}

struct WorkoutMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMenuView(workoutVM: WorkoutVM(workouts: [Workout.legs]))
    }
}
