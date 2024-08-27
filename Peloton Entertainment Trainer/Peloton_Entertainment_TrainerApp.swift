import SwiftUI

@main
struct YourAppNameApp: App {
    let workoutStore = WorkoutStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workoutStore)
        }
    }
}
