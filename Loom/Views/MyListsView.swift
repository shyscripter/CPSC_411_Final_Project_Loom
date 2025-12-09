//
//  MyListsView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct MyListsView: View {
    
    // Get all lists that exist in the database
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        
        // Objects inside of this stack can be interacted to open sub-menus
        NavigationStack {
            
            if myLists.isEmpty {
                // Show that this category is empty
                Spacer()
                Text("No reminders found")
                
            } else {
                
                // Iterate through all reminders if the list is not empty
                ForEach(myLists) { myList in
                    
                    // Create links to everything
                    NavigationLink(value: myList) {
                        VStack {
                            
                            // Create a view displaying the name and color of each list in its own struct
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                
                // Whole menu is scrollable, not each individual list
                }.scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        // Create a navigaiton title in each navigation's destination and show list details
                        MyListDetailView(myList: myList)
                            .navigationTitle(myList.name)
                    }
            }
            
        }
    }
}

/*
#Preview {
    MyListsView()
}
*/
