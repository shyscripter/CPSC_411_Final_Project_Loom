//
//  SelectListView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct SelectListView: View {
    
    // Fetch request to select a particular list and remember it
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        
        // List all existing and new lists in order from top to bottom
        // List instead of VStack to allow dynamic behavior
        List(myListsFetchResults) { myList in
            
            // Place every attribute of the list from left to right
            HStack {
                
                // Place the icon and name next to each other without taking too much space
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment:.leading)
                .contentShape(Rectangle())
                // Tapping binds the list to selection
                .onTapGesture {
                    self.selectedList = myList
                }
                
                // Space in between
                Spacer()
                
                // Give a check mark to indicate this list is selected on the right side of the screen
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

// Preview functionality
#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
