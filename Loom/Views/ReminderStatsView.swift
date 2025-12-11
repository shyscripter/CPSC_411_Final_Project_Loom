//
//  ReminderStatsView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct ReminderStatsView: View {
    
    // Icon, title, amount, and color for a particular stat
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color = .white
    let frameColor: Color
    
    var body: some View {
        
        // Stack elements on top of each other
        VStack {
            
            // Horizontal stack to allow text to be on the left and icons/count after it on the right
            HStack {
                
                // Embedded stack inside of horizontal alignment to take the whole left-side of the screen
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                
                // Spacing in between
                Spacer()
                
                // Show the count if it exists
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
               
            // Give padding to all elements inside the whole horizontal stack
            }.padding()
                .frame(maxWidth: .infinity)
                .background(frameColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

// Preview functionality (hardcoded for display testing)
#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 9, frameColor: .blue)
}
