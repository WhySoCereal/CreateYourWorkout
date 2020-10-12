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
    
    static func fetchWorkout(workout: Workout) -> NSFetchRequest<Workout> {
        let request = NSFetchRequest<Workout>(entityName: "Workout")
        request.predicate = NSPredicate(format: "id == %@", workout.id! as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        return request
    }
    
    var name: String {
        get { name_ ?? "Unknown" }
        set { name_ = newValue }
    }
    
    var exercises: Array<Exercise> {
        get {
            exercises_?.sortedArray(
                using:[NSSortDescriptor(key: "order_", ascending: true)]
            ) as! Array<Exercise>
        }

        //set { exercises_ = NSOrderedSet(object: newValue) }
    }
}
