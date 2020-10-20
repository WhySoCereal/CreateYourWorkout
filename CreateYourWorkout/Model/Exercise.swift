//
//  Exercise.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 05/10/2020.
//

import Foundation
import CoreData

extension Exercise {
    static func fetchWorkoutExercises(forWorkout workoutId: UUID) -> NSFetchRequest<Exercise> {
        let request: NSFetchRequest<Exercise> = NSFetchRequest(entityName: "Exercise")
        request.predicate = NSPredicate(format: "workout_.id_ = %@", workoutId as CVarArg)
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
    
    var isReps: Bool {
        reps != 0 ? true : false
    }
    
    var isTimed: Bool {
        time != 0 ? true : false
    }
}

extension Exercise: Comparable {
    public static func < (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.order < rhs.order
    }
}

// MARK: - For Testing and previews
extension Exercise {
    static func timedExerciseTest() -> Exercise {
        let ex = Exercise()
        ex.name = "Timed Exercise"
        ex.reps = 0
        ex.time = 100
        ex.order = 0
        return ex
    }
    
    static func repsExerciseTest() -> Exercise {
        let ex = Exercise()
        ex.name = "Repetitions Exercise"
        ex.reps = 100
        ex.time = 0
        ex.order = 0
        return ex
    }
}
