//
//  ContentView.swift
//  Workouts
//
//  Created by Alex on 12/31/23.
//

import SwiftUI

struct Exercise: Identifiable {
    let name: String
    let sets: [Int]
    let id = UUID()
}

struct ContentView: View {
    @State private var name: String = ""
    
    var body: some View {
        TabView {
            WorkoutView().tabItem {
                Label("Workout", systemImage: "dumbbell")
            }
        }
    }
}

#Preview {
    ContentView()
}
