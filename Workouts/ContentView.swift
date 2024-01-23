//
//  ContentView.swift
//  Workouts
//
//  Created by Alex on 12/31/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var isAddSheetShowing = false
    @State private var isSettingsSheetShowing = false
    @State private var newWorkoutName = ""
    @State private var newWorkoutDate: Date = .now
    
    @Query var workouts: [Workout]
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    // NavigationLink(destination: WorkoutView(workout: workout)) {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                                .font(.headline)
                            Text(workout.date.formatted(date: .numeric, time: .omitted))
                                .font(.callout)
                        }
                    // }
                }
                //.onDelete { workouts.remove(atOffsets: $0) }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: { isSettingsSheetShowing = true }) {
                        Image(systemName: "gear")
                    }.sheet(isPresented: $isSettingsSheetShowing) {
                        SettingsView()
                    }
                    Spacer()
                    Button(action: { isAddSheetShowing = true }) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $isAddSheetShowing) {
                        NavigationView {
                            Form {
                                TextField("Name", text: $newWorkoutName)
                                DatePicker("Date", selection: $newWorkoutDate, displayedComponents: [.date])
                            }
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel", action: { isAddSheetShowing = false })
                                }
                                ToolbarItem(placement: .principal) {
                                    Text("Add Workout").font(.headline)
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done", action: { addWorkout() }).disabled(newWorkoutName.count == 0)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addWorkout() {
        if (newWorkoutName.count > 0) {
            context.insert(Workout(name: newWorkoutName, date: newWorkoutDate))
            isAddSheetShowing = false
            newWorkoutName = ""
            newWorkoutDate = .now
        }
    }
}

#Preview {
    ContentView()
        .modelContainer (for: Workout.self)
}
