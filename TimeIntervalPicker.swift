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
    
    private var minutes: String {
        let x = Int(value / 60)
        return x < 10 ? "0\(x)" : "\(x)"
    }
    
    private var seconds: String {
        let x = Int(value) % 60
        return x < 10 ? "0\(x)" : "\(x)"
    }
    
    private var timerText: some View {
        Text("\(minutes) : \(seconds)")
            .lineLimit(1)
    }
    
    private var timePicker: some View {
        HStack {
            Picker("\(minutes)", selection: $value) {
                ForEach(0..<60) { seconds in
                    Text(secondsToString(seconds: seconds))
                        .frame(maxWidth: 30)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: 40, maxHeight: 80)
            .clipped()
            
            Text(":")
            Picker("\(seconds)", selection: $value) {
                ForEach(0..<60) { seconds in
                    Text(secondsToString(seconds: seconds))
                }
            }
            .pickerStyle(InlinePickerStyle())
            .frame(maxWidth: 40, maxHeight: 80)
            .clipped()
        }
        
        
    }
    
    private func secondsToString(seconds: Int) -> String {
        (seconds < 10) ? "0\(seconds)" : String(seconds)
    }

    
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()

            timePicker
//            RoundedRectangle(cornerRadius: cornerRadius)
//                .foregroundColor(Color(#colorLiteral(red: 0.8771176934, green: 0.8771176934, blue: 0.8771176934, alpha: 1)))
//                .overlay(timePicker)
//                .frame(maxWidth: 500)
                
        }
    }
}

struct TimeIntervalPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            TimeIntervalPicker(title: "Time Interval:", value: .constant(0))
        }
        
    }
}
