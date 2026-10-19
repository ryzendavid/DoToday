//
//  MainTabView.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 06/09/2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView(){
            Tab("Today", systemImage: "doc.text.image"){
                ToadyView(TodayChartData: weeklyStats)
            }
            
            Tab("Profile", systemImage: "person.and.background.striped.horizontal"){
                UserProfile_View()
            }
        }
    }
}

#Preview {
    MainTabView()
}
