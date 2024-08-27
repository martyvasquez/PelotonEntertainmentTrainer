import SwiftUI

struct CreateWorkoutView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var workoutName = ""
    @State private var intervals: [(id: UUID, duration: Int, cadence: Int, resistance: Int)] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
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
                    Button("Save Workout") {
                        workoutStore.addWorkout(name: workoutName, intervals: intervals.map { ($0.duration, $0.cadence, $0.resistance) })
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Create Workout")
        }
    }
    
    private func binding(for interval: (id: UUID, duration: Int, cadence: Int, resistance: Int)) -> Binding<(id: UUID, duration: Int, cadence: Int, resistance: Int)> {
        guard let index = intervals.firstIndex(where: { $0.id == interval.id }) else {
            fatalError("Can't find interval in array")
        }
        return $intervals[index]
    }
    
    func deleteInterval(at offsets: IndexSet) {
        intervals.remove(atOffsets: offsets)
    }
}

struct CreateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutView().environmentObject(WorkoutStore())
    }
}
