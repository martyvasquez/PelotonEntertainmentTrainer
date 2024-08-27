import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    
    var body: some View {
        List {
            ForEach(workout.intervalsArray, id: \.self) { interval in
                HStack {
                    Text("Duration: \(interval.duration)s")
                    Spacer()
                    Text("Cadence: \(interval.cadence)")
                    Spacer()
                    Text("Resistance: \(interval.resistance)")
                }
            }
        }
        .navigationTitle(workout.name ?? "Workout Details")
        .toolbar {
            NavigationLink(destination: ActiveWorkoutView(workout: workout)) {
                Text("Start Workout")
            }
        }
    }
}

extension Workout {
    var intervalsArray: [Interval] {
        let set = intervals as? Set<Interval> ?? []
        return set.sorted { $0.id < $1.id }
    }
}
