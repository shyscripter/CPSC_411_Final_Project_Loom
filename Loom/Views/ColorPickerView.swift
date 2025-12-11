//
//  ColorPickerView.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import SwiftUI

struct ColorPickerView: View {
    
    // Flag to remember the selected color the user gives, with a default provided on init
    @Binding var selectedColor: Color
    
    // All allowed UI colors are hardcoded
    let colors: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .purple, .pink]
    
    var body: some View {
        
        // Define a grid layout with four flexible columns
        let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        // Using ScrollView allows the grid to scroll if there are many colors
        ScrollView {
            
            // LazyVGrid arranges items in a vertical grid using the defined columns
            LazyVGrid(columns: columns, spacing: 10) {
                
                // Iterates through each existing color
                ForEach(colors, id: \.self) { color in
                    
                    // ZStack allows icon elements to be layered on top of each other
                    ZStack {
                        Circle().fill()
                            .foregroundColor(color)
                            .padding(2)
                        
                        // Outer circle for selection indicator
                        Circle()
                            .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 4)
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }
                    .frame(width: 40, height: 40)
                    
                    // Pressing the button assigns the color
                    .onTapGesture {
                        selectedColor = color
                    }
                }
            }
            // Adds padding around the entire grid
            .padding()
        }
        // .frame(maxWidth: .infinity, maxHeight: 100) // The frame might restrict the grid,
                                                       // consider removing or adjusting it.
        // .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        
    }
}

// Preview with a hardcoded default color
#Preview {
    ColorPickerView(selectedColor: .constant(.yellow))
}
