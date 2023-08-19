//
//  Day.swift
//  CalendarReminder
//
//  Created by Shalopay on 17.08.2023.
//

import Foundation

struct Day {
    let weekday: String
    let day: Int
    let month: String
    let year: Int
    var notes = [Note]()
}

struct Note {
    var text: String
    var dataToFrom: String = ""
    var status: Bool = false
}


enum Month: Int, CaseIterable {
    case None = 0
    case January = 1
    case February = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
    var name: String {
        switch self {
        case .None:
            return "None"
        case .January:
            return "January"
        case .February:
            return "February"
        case .March:
            return "March"
        case .April:
            return "April"
        case .May:
            return "May"
        case .June:
            return "June"
        case .July:
            return "July"
        case .August:
            return "August"
        case .September:
            return "September"
        case .October:
            return "October"
        case .November:
            return "November"
        case .December:
            return "December"
        }
    }
}

enum WeekDay: Int, CaseIterable {
    case None = 0
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    var name: String {
        switch self {
        case .Sunday:
            return "Sunday"
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        case .None:
            return "NoNe"
        }
    }
}
