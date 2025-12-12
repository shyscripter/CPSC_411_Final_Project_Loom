//
//  SettingsView.swift
//  Loom
//
//  Created by Aaron Haight on 12/11/25.
//

import SwiftUI

struct SettingsView: View {
    
    // Dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        // All settings stored in this scrollable view
        ScrollView {
            
            // Dark mode toggle
            Toggle(isOn: $isDarkMode) {
                Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
            }
            .padding(.horizontal)
            .padding(.top)
            
        }
        
    }
}

#Preview {
    SettingsView()
}
