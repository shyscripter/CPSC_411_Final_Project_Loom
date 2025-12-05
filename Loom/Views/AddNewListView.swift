//
//  AddNewListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: Color = .yellow
    
    let onSave: (String, UIColor) -> Void
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(selectedColor)
                .font(.system(size: 100))
            
            TextField("List Name", text: $name)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
        }
        .padding(30)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        
        ColorPickerView(selectedColor: $selectedColor)
        
        Spacer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // FIXED LINE 32 BELOW:
                    Text("New List")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        
                        // save the list
                        onSave(name, UIColor(selectedColor))
                        
                        dismiss()
                    }.disabled(isFormValid)
                }
            }
    }
}

#Preview {
    NavigationView {
        AddNewListView(onSave: { (_, _) in })
    }
}
