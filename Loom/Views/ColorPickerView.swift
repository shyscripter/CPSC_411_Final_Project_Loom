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
        
        // Creates ordered buttons of each color that's hardcoded above
        HStack {
            
            // Iterates through each existing color
            ForEach(colors, id: \.self) { color in
                
                // Stack creates icons for each color that exists in the hardcoded list
                ZStack {
                    Circle().fill()
                        .foregroundColor(color)
                        .padding(2)
                    Circle()
                        .strokeBorder(selectedColor == color ? .gray: .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                }.onTapGesture {
                    selectedColor = color // Pressing the button assigns the color
                }
                
            }.padding()
                .frame(maxWidth: .infinity, maxHeight: 100)
                //.background(Color.primaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
        
    }
}

// Preview with a hardcoded default color
#Preview {
    ColorPickerView(selectedColor: .constant(.yellow))
}
