import Foundation
import CoreData

extension Workout {
    var sortedIntervals: [Interval] {
        let intervalSet = intervals as? Set<Interval> ?? []
        return intervalSet.sorted { (interval1, interval2) -> Bool in
            let timestamp1 = interval1.timestamp ?? Date.distantPast
            let timestamp2 = interval2.timestamp ?? Date.distantPast
            return timestamp1 < timestamp2
        }
    }
}
