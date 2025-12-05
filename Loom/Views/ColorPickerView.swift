//
//  ColorPickerView.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var selectedColor: Color
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    var body: some View {
        
        // Creates buttons of each existing color category to group reminders
        HStack {
            ForEach(colors, id: \.self) { color in
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

#Preview {
    ColorPickerView(selectedColor: .constant(.yellow))
}
