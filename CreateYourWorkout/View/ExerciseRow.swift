//
//  ExerciseRow.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 20/10/2020.
//

import SwiftUI

struct ExerciseRow: View {
    var exercise: Exercise
    
    var timeToString: String {
        return "10 seconds"
    }
    
    var body: some View {
        HStack {
            Text(exercise.name)
                .font(Font.system(size: 20))
            Spacer()
            Text(timeToString)
                .font(Font.system(size: 10))
                .foregroundColor(.gray)
        }
        
    }
}
