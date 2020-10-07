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
                    NavigationLink(destination: WorkoutView(workout)) {
                        EditableText(workout.name, isEditing: editMode.isEditing) { newName in
                            workout.name = newName
                            
                            try? context.save()
                        }
                    }
                }
                .onDelete { indexSet in
                    let deletedItem = workouts[indexSet.first!]
                    context.delete(deletedItem)
                    
                    try? context.save()

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
                try? context.save()
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

}


struct WorkoutMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMenuView()
    }
}
