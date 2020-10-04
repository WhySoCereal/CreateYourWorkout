//
//  TextFieldAlert.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 04/10/2020.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isPresented: Bool
    let placeholderText: String
    @Binding var text: String
    let presenting: Presenting
    let title: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                presenting.disabled(isPresented)
                
                VStack {
                    
                    Text(title)
                        .bold()

                    TextField(placeholderText, text: $text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(Font.body.weight(.bold))
                        .id(isPresented)
                        
                    Divider()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isPresented.toggle()
                                text = ""
                            }
                        }) {
                            Text("Cancel")
                        }
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isPresented.toggle()
                            }
                        }) {
                            Text("Add")
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white).shadow(radius: 5))
                .frame(
                    width: deviceSize.size.width * 0.7,
                    height: deviceSize.size.height * 0.7
                )
                .opacity(isPresented ? 1 : 0)
            }
        }
    }

}

extension View {
    func textFieldAlert(isPresented: Binding<Bool>,
                        placeholderText: String,
                        text: Binding<String>,
                        title: String) -> some View {
        TextFieldAlert(isPresented: isPresented,
                       placeholderText: placeholderText,
                       text: text,
                       presenting: self,
                       title: title)
    }

}
