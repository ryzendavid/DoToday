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
    @State private var TodayEntry : [DailyEntry] = []
    
    
    var body: some View {

        
        NavigationStack{
            ScrollView{
                VStack (alignment: .leading){
                    
                    //call todayCardView
                    
                    ForEach(TodayEntry){ Entry in
                        TodayCardView(entry: Entry)
                    }
                    
                    //TodayCardView()
        
                    
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


// defines today card view
struct TodayCardView : View {
    var entry : DailyEntry
    var number = ["Hello", "hey", "goof"]
    
    var body : some View{
        VStack(alignment: .leading){
            Text(entry.title)
                .bold()
                .font(.custom("Caacupe One", size: 40))
            
            Image(entry.image)
                .resizable()
                .frame(width: .infinity, height: 300)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            ForEach(number, id: \.self){ num in
                Text(num)
            }
        }
        
    }
}
