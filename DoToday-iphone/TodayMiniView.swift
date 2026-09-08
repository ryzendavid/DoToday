//
//  TodayView.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 08/09/2026.
//

import SwiftUI

struct TodayMiniView: View {
    var body: some View {
        VStack{
            Image("train")
                .resizable()
            //.aspectRatio(contentMode: .fill)
                .frame(width:.infinity, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            
            Text("Lovely day on the Train today")
                .font(.custom("Caacupe One", size: 30))
}
    }
}

#Preview {
    TodayMiniView()
}
