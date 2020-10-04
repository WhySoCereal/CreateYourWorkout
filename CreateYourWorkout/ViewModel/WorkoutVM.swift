//
//  WorkoutVM.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//

import Foundation

class WorkoutVM: ObservableObject {
    @Published public var workouts: [Workout]
    
    init(workouts: [Workout]) {
        // get workouts from CoreData database
        self.workouts = workouts
    }
    
    
}
