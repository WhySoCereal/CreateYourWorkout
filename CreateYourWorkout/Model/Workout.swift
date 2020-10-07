//
//  Workout.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//



import CoreData
import Combine

extension Workout {
    static func fetchAll() -> NSFetchRequest<Workout> {
        let request = NSFetchRequest<Workout>(entityName: "Workout")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        return request
    }
    
    var name: String {
        get { name_ ?? "Unknown" }
        set { name_ = newValue }
    }
    
    var exercises: Set<Exercise> {
        get { exercises_ as? Set<Exercise> ?? [] }
        set { exercises_ = newValue as NSSet }
    }
}
