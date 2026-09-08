//
//  DoToday_iphoneApp.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 06/09/2026.
//

import SwiftUI

@main
struct DoToday_iphoneApp: App {
    var body: some Scene {
        WindowGroup {
            ToadyView(TodayChartData: weeklyStats)
        }
    }
}
