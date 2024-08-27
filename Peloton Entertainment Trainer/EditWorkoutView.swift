import SwiftUI

struct EditWorkoutView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var workoutName: String
    @State private var intervals: [(id: UUID, duration: Int, cadence: Int, resistance: Int)]
    let workout: Workout
    @Environment(\.presentationMode) var presentationMode

    init(workout: Workout) {
        self.workout = workout
        _workoutName = State(initialValue: workout.name ?? "")
        _intervals = State(initialValue: workout.sortedIntervals.map { interval in
            (id: UUID(), duration: Int(interval.duration), cadence: Int(interval.cadence), resistance: Int(interval.resistance))
        })
    }

    var body: some View {
        Form {
            Section(header: Text("Workout Name")) {
                TextField("Enter workout name", text: $workoutName)
            }
            
            Section(header: Text("Intervals")) {
                ForEach(intervals, id: \.id) { interval in
                    IntervalRow(interval: binding(for: interval))
                }
                .onDelete(perform: deleteInterval)
                
                Button("Add Interval") {
                    intervals.append((id: UUID(), duration: 60, cadence: 80, resistance: 5))
                }
            }
            
            Section {
                Button("Save Changes") {
                    workoutStore.updateWorkout(workout, name: workoutName, intervals: intervals)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Edit Workout")
    }
    
    private func binding(for interval: (id: UUID, duration: Int, cadence: Int, resistance: Int)) -> Binding<(id: UUID, duration: Int, cadence: Int, resistance: Int)> {
        guard let index = intervals.firstIndex(where: { $0.id == interval.id }) else {
            fatalError("Can't find interval in array")
        }
        return $intervals[index]
    }
    
    private func deleteInterval(at offsets: IndexSet) {
        intervals.remove(atOffsets: offsets)
    }
}
