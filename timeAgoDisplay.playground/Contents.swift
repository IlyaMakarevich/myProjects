import UIKit

var str = "Hello, playground"


let now = Date()
let postDate = Date(timeIntervalSinceNow: -60 * 62)

extension Date {
    func timeAgoDisplay() -> String {
        let secodsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secodsAgo < minute {
             return ("seconds ago: \(secodsAgo)")
        } else if secodsAgo < hour {
            return ("minutes ago: \(secodsAgo / minute)")
        } else if secodsAgo < day {
        return ("hours ago: \(secodsAgo / hour)")
        } else if secodsAgo < week {
            return ("days ago: \(secodsAgo / day)")
        }
    
        return ("weeks ago: \(secodsAgo / week)")
         
    }
}

postDate.timeAgoDisplay()
