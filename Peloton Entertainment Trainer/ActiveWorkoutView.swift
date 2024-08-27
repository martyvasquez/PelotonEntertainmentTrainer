import SwiftUI
import CoreData

struct ActiveWorkoutView: View {
    let workout: Workout
    @State private var currentIntervalIndex = 0
    @State private var timeRemaining: Int = 0
    @State private var totalTimeRemaining: Int = 0
    @State private var isRunning = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(workout.name ?? "Active Workout")
                .font(.largeTitle)
            
            Text("Interval \(currentIntervalIndex + 1) of \(workout.sortedIntervals.count)")
                .font(.headline)
            
            Text("Total Time Remaining: \(formatTime(totalTimeRemaining))")
                .font(.title2)
            
            Text("Current Interval: \(formatTime(timeRemaining))")
                .font(.title)
            
            if currentIntervalIndex < workout.sortedIntervals.count {
                Text("Cadence: \(workout.sortedIntervals[currentIntervalIndex].cadence)")
                    .font(.title2)
                
                Text("Resistance: \(workout.sortedIntervals[currentIntervalIndex].resistance)")
                    .font(.title2)
            }
            
            Button(isRunning ? "Pause" : "Start") {
                isRunning.toggle()
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            initializeWorkout()
        }
    }
    
    private func initializeWorkout() {
        if !workout.sortedIntervals.isEmpty {
            timeRemaining = Int(workout.sortedIntervals[currentIntervalIndex].duration)
            totalTimeRemaining = workout.sortedIntervals.reduce(0) { $0 + Int($1.duration) }
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
