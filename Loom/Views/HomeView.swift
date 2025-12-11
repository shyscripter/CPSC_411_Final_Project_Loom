//
//  ContentView.swift
//  Loom
//
//  Created by Aaron Haight on 11/24/25.
//

import SwiftUI

// Main view that is used to initialize the rest of the app's UI components
struct HomeView: View {
    
    // Request for list finding
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    // Request for reminder finding
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    // Get all reminders with a scheduled date within today
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.today))
    private var todayResults: FetchedResults<Reminder>
    
    // Get all reminders with a scheduled date OR time
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    
    // Get all reminders marked as completed
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.completed))
    private var completedResults: FetchedResults<Reminder>
    
    // Get ALL reminders
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(.all))
    private var allResults: FetchedResults<Reminder>
    
    // Search bar flags to dictate how the UI responds to user input
    @State private var search: String = ""
    @State private var searching: Bool = false
    @State private var isPresented: Bool = false
    
    // Build reminder stats using custom struct
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    // Initialize the view this struct uses
    var body: some View {
        
        // Navigation stack to allow compatibility for NavigationLink items below
        NavigationStack {
            
            // Vertical stack to place everything on top of each other
            VStack {
                
                // Allow the entire menu to be scrollable by wrapping everything in a ScrollView
                ScrollView {
                    
                    // Two buttons on the top of a 2x2 grid
                    HStack {
                        
                        // Navigation to today's reminders
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount, frameColor: .red)
                        }
                        
                        // Navigation to all reminders
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, frameColor: .blue)
                        }
                    }
                    
                    // Two buttons on the bottom of a 2x2 grid
                    HStack {
                        
                        // Navigation to scheduled reminders
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "clock", title: "Scheduled", count: reminderStatsValues.scheduledCount, frameColor: .yellow)
                        }
                        
                        // Navigaiton to completed reminders
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, frameColor: .green)
                        }
                        
                    }
                    
                    // Header above the display of user-created categories
                    Text("Categories")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    // View all existing lists
                    MyListsView(myLists: myListResults)
                        .frame(height: CGFloat(myListResults.count) * 30) // Dynamic counting required because of a SwiftUI bug
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add Category")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }
            .sheet(isPresented: $isPresented) {
                
                // Create a navigation view linking to the menu to create a new category and save to database when presented
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onChange(of: search, perform: {searchTerm in
                // Search bar functionality for when the text in the bar is changed
                searching = !searchTerm.isEmpty ? true: false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                // Overlay the reminder list on top of the rest of the UI when searching
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0: 0.0)
            })
            .onAppear {
                // Get new reminder stats every time this menu is (re)loaded
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .navigationTitle("Your Reminders")
        }.searchable(text: $search) // Binds the search string to the search bar
    }
    
}

// Preview functionality
struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
