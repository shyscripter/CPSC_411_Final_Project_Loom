//
//  MyListCellView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct MyListCellView: View {
    
    // Reference to view a given list
    let myList: MyList
    
    var body: some View {
        
        // Horizontally space each item together
        HStack {
            
            // Image on the very left
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(Color(myList.color))
            
            // Show the name of the list
            Text(myList.name)
            
            // Add spacing
            Spacer()
            
            // Right-facing arrow on the right side of the cell to show this can be opened
            // This just makes it a little more obvious that you can interact with categories
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
        }
    }
}

// Preview functionality
#Preview {
    MyListCellView(myList: PreviewData.myList)
}
