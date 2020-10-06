//
//  ContentView.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//

import SwiftUI
import CoreData

struct WorkoutMenuView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: Workout.fetchAll()) var workouts: FetchedResults<Workout>
    
    @State var editMode: EditMode = .inactive
    @State private var newWorkoutItem = ""
    @State private var addWorkoutShow = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(destination: WorkoutView()) {
                        EditableText("\(workout.name!)", isEditing: editMode.isEditing) { newName in
                            workout.name = newName
                            
                            do {
                                try context.save()
                            } catch(let error) {
                                print("Couldn't update name field in Workout entity: \(error.localizedDescription)")
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    let deletedItem = workouts[indexSet.first!]
                    context.delete(deletedItem)
                    
                    do {
                        try context.save()
                    } catch(let error) {
                        print("Couldn't delete a workout in Workout entity: \(error.localizedDescription)")
                    }
                }
            }
            .navigationTitle(Text("Workouts"))
            .navigationBarItems(leading: EditButton(), trailing: addWorkoutButton)
            .environment(\.editMode, $editMode)
        }
        .textFieldAlert(isPresented: $addWorkoutShow, placeholderText: "Name of workout", text: $newWorkoutItem, title: "New Workout", action: {

            if !newWorkoutItem.isEmpty {
                let workout = Workout(context: context)
                workout.name = newWorkoutItem
                newWorkoutItem.removeAll()
                do {
                    try context.save()
                } catch(let error) {
                    print("Couldn't save workout to CoreData: \(error.localizedDescription)")
                }
            }
        })
    }
    
    private var addWorkoutButton: some View {
        Button(action: {
            addWorkoutShow = true
        }, label: {
            Image(systemName: "plus")
        })
        .disabled(addWorkoutShow)
    }
//
//    private var editWorkoutButton: some View {
//        Button(action: {
//            editMode = .active
//        }, label: {
//            Text("Edit")
//        })
//    }
}


struct WorkoutMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMenuView()
    }
}
