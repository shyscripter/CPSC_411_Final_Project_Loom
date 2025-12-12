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
            
        }
        
    }
}

#Preview {
    SettingsView()
}
