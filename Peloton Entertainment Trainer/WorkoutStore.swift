import CoreData
import SwiftUI

class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PelotonEntertainmentTrainer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        fetchWorkouts()
    }

    func fetchWorkouts() {
        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        do {
            workouts = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching workouts: \(error)")
        }
    }

    func addWorkout(name: String, intervals: [(duration: Int, cadence: Int, resistance: Int)]) {
        let newWorkout = Workout(context: container.viewContext)
        newWorkout.name = name
        
        for intervalData in intervals {
            let newInterval = Interval(context: container.viewContext)
            newInterval.duration = Int32(intervalData.duration)
            newInterval.cadence = Int32(intervalData.cadence)
            newInterval.resistance = Int32(intervalData.resistance)
            newInterval.workout = newWorkout
        }
        
        saveContext()
    }

    func deleteWorkout(_ workout: Workout) {
        container.viewContext.delete(workout)
        saveContext()
    }

    func updateWorkout(_ workout: Workout, name: String, intervals: [(id: UUID, duration: Int, cadence: Int, resistance: Int)]) {
        workout.name = name
        
        // Remove existing intervals
        if let existingIntervals = workout.intervals as? Set<Interval> {
            existingIntervals.forEach { container.viewContext.delete($0) }
        }
        
        // Add new intervals
        for intervalData in intervals {
            let newInterval = Interval(context: container.viewContext)
            newInterval.duration = Int32(intervalData.duration)
            newInterval.cadence = Int32(intervalData.cadence)
            newInterval.resistance = Int32(intervalData.resistance)
            newInterval.workout = workout
        }
        
        saveContext()
    }

    private func saveContext() {
        do {
            try container.viewContext.save()
            fetchWorkouts()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
