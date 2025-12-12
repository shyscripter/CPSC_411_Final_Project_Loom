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
        }
    }
}

// Preview functionality
#Preview {
    MyListCellView(myList: PreviewData.myList)
}
