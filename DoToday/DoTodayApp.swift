//
//  DoTodayApp.swift
//  DoToday
//
//  Created by David Adekunle on 06/09/2026.
//

import SwiftUI

@main
struct DoTodayApp: App {
    var body: some Scene {
        WindowGroup {
            ToadyView(TodayChartData: weeklyStats)
        }
    }
}
