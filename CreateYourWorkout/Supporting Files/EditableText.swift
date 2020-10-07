//
//  EditableText.swift
//  CreateYourWorkout
//
//  Created by Brian Alldred on 06/10/2020.
//

import SwiftUI

struct EditableText: View {
    var text: String = ""
    var isEditing: Bool
    var onChanged: (String) -> Void

    init(_ text: String, isEditing: Bool, onChanged: @escaping (String) -> Void) {
        self.text = text
        self.isEditing = isEditing
        self.onChanged = onChanged
    }
    
    @State private var editableText: String = ""
            
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(text, text: $editableText, onEditingChanged: { began in
                callOnChangedIfChanged()
            })
                .opacity(isEditing ? 1 : 0)
                .disabled(!isEditing)
            if !isEditing {
                Text(text)
                    .opacity(isEditing ? 0 : 1)
                    .onAppear {
                        // any time we move from editable to non-editable
                        // we want to report any changes that happened to the text
                        // while were editable
                        // (i.e. we never "abandon" changes)
                        callOnChangedIfChanged()
                }
            }
        }
        .onAppear { editableText = text }
    }
    
    func callOnChangedIfChanged() {
        if editableText != text {
            onChanged(editableText)
        }
    }
}
