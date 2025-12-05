//
//  ContentView.swift
//  Loom
//
//  Created by Aaron Haight on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello world")
                
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // save the list to the database
                    }
                }
            }
        }
        .padding()
    }
    
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
