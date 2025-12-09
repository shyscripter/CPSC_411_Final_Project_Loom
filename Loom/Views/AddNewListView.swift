//
//  AddNewListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import SwiftUI

struct AddNewListView: View {
    
    // Variables for the name and color of each new list
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedColor: Color = .yellow
    
    // Closure to save
    let onSave: (String, UIColor) -> Void
    
    // Control flag to make sure a list can be properly saved
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        
        // Stack for all existing lists and color pickers
        VStack {
            
            // Padded stack to preview the new list that is being saved
            VStack {
                
                // List icon colored as the user defined it when saving
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(selectedColor)
                    .font(.system(size: 100))
                
                // Text field to display the name of the list
                TextField("List Name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            // Create a color picker below the bottom of the first stack
            ColorPickerView(selectedColor: $selectedColor)
            
            // Put some extra space between this and the next item
            Spacer()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        // Creates a toolbar on top to create a new list
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New List")
                    .font(.headline)
            }
            
            // Close button on top left
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            // Done with the naming on the top right
            // Only enabled when the name is saveable
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    
                    // Save the list when the button is clicked
                    onSave(name, UIColor(selectedColor))
                    
                    dismiss()
                }.disabled(!isFormValid)
            }
        }
    }
}

// Preview functionality
#Preview {
    NavigationView {
        AddNewListView(onSave: { (_, _) in })
    }
}
