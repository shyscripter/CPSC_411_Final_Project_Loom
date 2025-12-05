//
//  AddNewListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/4/25.
//

import SwiftUI

struct AddNewListView: View {
    
    @State private var name: String = ""
    
    var body: some View {
        
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 100))
            TextField("List Name", text: $name)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
        }
        .padding(30)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        
        Spacer()
    }
    
}

#Preview {
    AddNewListView()
}
