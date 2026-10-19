//
//  ContentView.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 06/09/2026.
//

import SwiftUI
import Charts

struct ToadyView: View {
    
    var TodayChartData : [ChartsData]
    @AppStorage("userStreak") var userStreak = 0
    @State var todayentryView = false
    
    var body: some View {

        
        NavigationStack{
            ScrollView{
                VStack (alignment: .leading){
                    Text("Hello *name what have you done today?")
                        .bold()
                        .font(.custom("Caacupe One", size: 35))
                    Spacer()
                    
                    Text("I Saw  *this Today")
                        .bold()
                        .font(.custom("Caacupe One", size: 40))
                    
                    Image("train")
                        .resizable()
                        .frame(width: .infinity, height: 300)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Button{
                        todayentryView = true
                    }label: {
                        Text("Enter entry")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Your Stats")
                            .bold()
                            .font(.custom("Caacupe One", size: 40))
                        
                    }
                    .padding(.top)
                    
                    Chart(TodayChartData){ data in
                        BarMark(
                            x: .value("Day", data.day),
                            y: .value("Tasks", data.completedTasks)
                        )
                        
                    }
                    
                    Text("Streak : \(userStreak)")
                        .font(.custom("Caacupe One", size: 40))
                }
                .padding()
                .sheet(isPresented: $todayentryView){
                    UserEntryView()
                }
                
                
            }
            .navigationTitle("Do Today")
        }
    }
}

#Preview {
    ToadyView(TodayChartData: weeklyStats)
}
