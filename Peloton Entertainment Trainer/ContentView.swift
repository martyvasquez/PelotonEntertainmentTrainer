import SwiftUI

struct ContentView: View {
    @StateObject private var workoutStore = WorkoutStore()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WorkoutListView()
                .tabItem {
                    Label("Workouts", systemImage: "list.bullet")
                }
                .tag(0)
            
            CreateWorkoutView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
                .tag(1)
        }
        .environmentObject(workoutStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
