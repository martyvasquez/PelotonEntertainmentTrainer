import SwiftUI

struct WorkoutListView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var workoutToEdit: Workout?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workoutStore.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        Text(workout.name ?? "Unnamed Workout")
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            deleteWorkout(workout)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            workoutToEdit = workout
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreateWorkoutView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $workoutToEdit) { workout in
                NavigationView {
                    EditWorkoutView(workout: workout)
                }
            }
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        workoutStore.deleteWorkout(workout)
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
            .environmentObject(WorkoutStore())
    }
}
