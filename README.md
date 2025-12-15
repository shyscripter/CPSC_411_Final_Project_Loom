# Loom - The Productivity App
This application was created as a project for CPSC 411 - iOS App Development. This repository will temporarily be public and will be private again when the grading period is over.

## Deployment Instructions
### Requirements
- macOS with Xcode installed (recent version that supports SwiftUI and iOS 17 or later).
- An iOS simulator (built into Xcode) or a physical iPhone.
- For running on a real device, an Apple ID added to Xcode for code signing.
## Setting Up The Project
- Download or unzip the project folder CPSC_411_Final_Project_Loom.
- Open` Loom.xcodeproj` in Xcode.
- In the Xcode toolbar, select the Loom target.
- Verify that the target iOS version in Deployment Info matches your simulator or device (e.g., iOS 17+).
## Deploying To A Simulator
- In Xcode, pick an iOS Simulator
- Press Run
- Xcode will build the app and automatically launch it in the simulator.
## How To Use The Application
### First Launch
- Open the Loom app on the simulator or device.
- When asked, allow notifications so reminder alerts can be delivered.
- The app opens to the HomeView, showing reminder stats and navigation to categories.
### Basic Usage Flow
#### Creating a Category
- Go to the Categories section.
- Tap the button to create a new category.
- Enter a name (e.g., “School”) and pick a color.
- Save the new category by pressing "Done".
#### Adding a Reminder
- Tap on a category to open its submenu.
- Tap the button to add a new reminder.
- Enter a title (required) and notes (optional).
- Optionally select a date and time if you want a notification.
Save the reminder.
#### Managing Reminders
In a category's submenu:
- Tap the checkbox/toggle to mark a reminder as completed.
- Swipe to delete a reminder if it’s no longer needed.
- Tap the info/detail button to open ReminderDetailView and edit fields.
#### Searching/Filtering
- From the home screen, type into the search bar to filter reminders by text.
- Use the summary/stat tiles (Today, Scheduled, Completed, All) to quickly see different sets of reminders
#### Change Appearance
- Use the app’s dark mode control (where provided in settings or UI).
- The entire app switches between light and dark themes and remembers your choice.
