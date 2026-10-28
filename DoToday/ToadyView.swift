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
    //var EntryModel = 
    
    
    var body: some View {

        
        NavigationStack{
            ScrollView{
                VStack (alignment: .leading){
                    
                    //call todayCardView
                    TodayCardView()
        
                    
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
    var number = ["Hello", "hey", "goof"]
    var body : some View{
        VStack(alignment: .leading){
            Text("I Saw  *this Today")
                .bold()
                .font(.custom("Caacupe One", size: 40))
            
            Image("train")
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
