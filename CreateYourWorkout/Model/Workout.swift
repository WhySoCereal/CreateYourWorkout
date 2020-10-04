//
//  Workout.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//

import Foundation

struct Exercise {
    var name: String?
    var time: Int?
    var reps: Int?
    
}

struct Workout: Identifiable {
    var id: UUID
    var name: String?
//    var emoji: Character?
//    var exercises: [Exercise]?
    
    static public var legs: Self = Self(id: UUID(), name: "Legs")
                                        //, emoji: "🏋🏿‍♂️", exercises: [Exercise(name: "Squats", time: 10, reps: 10), Exercise(name: "Deadlift", time: 20, reps: 20)])
}

