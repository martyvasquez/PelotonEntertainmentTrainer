import Foundation
import CoreData

extension Workout {
    var sortedIntervals: [Interval] {
        let intervalSet = intervals as? Set<Interval> ?? []
        return intervalSet.sorted { (interval1: Interval, interval2: Interval) -> Bool in
            let id1 = interval1.objectID.uriRepresentation().absoluteString
            let id2 = interval2.objectID.uriRepresentation().absoluteString
            return id1 < id2
        }
    }
}
