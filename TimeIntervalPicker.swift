//
//  TimeIntervalPicker.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 11/10/2020.
//

import SwiftUI

struct TimeIntervalPicker: View {
    @State var title: String
    @Binding var value: TimeInterval
    
    var minutes: String {
        let x = Int(value / 60)
        return x < 10 ? "0\(x)" : "\(x)"
    }
    
    var seconds: String {
        let x = Int(value) % 60
        return x < 10 ? "0\(x)" : "\(x)"
    }
    
    var cornerRadius: CGFloat = 13
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button("\(minutes) : \(seconds)") {
                
            }
            .padding(5)
            .background(RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))))
            
        }
    }
}

struct TimeIntervalPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimeIntervalPicker(title: "Time Interval", value: .constant(0))
    }
}
