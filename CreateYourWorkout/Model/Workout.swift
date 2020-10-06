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
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
}
