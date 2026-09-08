//
//  ChartsData.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 08/09/2026.
//

import Foundation

struct ChartsData: Identifiable {
    let id = UUID()
    let day : String
    let completedTasks : Int
}

let weeklyStats = [
    ChartsData(day: "Mon", completedTasks: 4),
    ChartsData(day: "Tue", completedTasks: 7),
    ChartsData(day: "Wed", completedTasks: 3),
    ChartsData(day: "Thu", completedTasks: 6),
    ChartsData(day: "Fri", completedTasks: 5),
    ChartsData(day: "Sat", completedTasks: 2),
    ChartsData(day: "Sun", completedTasks: 0)
]
