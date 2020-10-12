//
//  Exercise.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 05/10/2020.
//

import Foundation
import CoreData

extension Exercise {
    static func fetchWorkoutExercises(forWorkout workout: String) -> NSFetchRequest<Exercise> {
        let request: NSFetchRequest<Exercise> = NSFetchRequest(entityName: "Exercise")
        request.predicate = NSPredicate(format: "workout.name = %@", workout)
        request.sortDescriptors = [NSSortDescriptor(key: "order_", ascending: true)]
        return request
    }
    
    var name: String {
        get { name_ ?? "Unknown" }
        set { name_ = newValue }
    }
    
    var order: Int {
        get { Int(order_) }
        set { order_ = Int64(newValue) }
    }
    
    var reps: Int {
        get { Int(reps_) }
        set { reps_ = Int64(newValue) }
    }
}

extension Exercise: Comparable {
    public static func < (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.order < rhs.order
    }
    
    
}
