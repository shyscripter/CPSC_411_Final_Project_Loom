//
//  MyListsView.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import SwiftUI

struct MyListsView: View {
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        
        if myLists.isEmpty {
            
            Spacer()
            Text("No categories found")
            
        } else {
            
            // List added to allow dynamic interaction with lists
            List {
                
                // The ForEach iterates over the fetched data
                ForEach(myLists) { myList in
                    
                    NavigationLink(value: myList) {
                        
                        // Create a cell in the frame
                        MyListCellView(myList: myList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 10)
                            .font(.title3)
                        
                    }
                    
                }
                
            }.scrollContentBackground(.hidden)
            
        }
    }
}

/*
#Preview {
    MyListsView()
}
*/
