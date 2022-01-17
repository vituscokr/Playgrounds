//: [Previous](@previous)
import UIKit

var dateComponent  = DateComponents()
var dayComponent    = DateComponents()
dayComponent.day    = 100 // For removing one day (yesterday): -1
let theCalendar     = Calendar.current
let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
print("nextDate : \(nextDate)")

let components = Calendar.current.dateComponents([.month, .day], from: Date(), to: nextDate!)
print(components.month, components.day)

//: [Next](@next)
