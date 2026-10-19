//
//  UserEntryView.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 17/09/2026.
//

import SwiftUI
import PhotosUI

struct UserEntryView: View {
    
    @State private var txtField = ""
    @State private var SelectedphotoPicker : PhotosPickerItem?
    @State private var SelectedTodayImage : Image?
    
    var body: some View {
        NavigationStack{
            VStack{
//                Text("Hey, *Name what did you do today that made you happy")
                
                TextField("Describe what you did in a few phrases", text: $txtField)
                    .padding()
                
                Text("Did you get any photos? add them here")
                
                //add this to the button
                
                PhotosPicker(selection: $SelectedphotoPicker, matching: .images){
                    if let TodayImage = SelectedTodayImage{
                        TodayImage
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding()
                            .frame(width: .infinity, height: 320)
                            
                            
                            
                    }else{
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 150))
                            .padding()
                    }
                }
                
//                SelectedTodayImage?
//                    .resizable()
                    //.scaledToFit()
                    
                    
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .frame(width: 400, height: 300)
                    
                
                //when/if user has added a photo, remove the text/questions that asks if they need to add a photo, then change the select photo button/ add new button "Change photo" (or tapping the photo should bring up the photo picker view again..(can add as a tip maybe..) we'll limit to a single photo for now, if the app is released, multi photo will be an update.. i'm going to bed now.. 
                    
                Button{
                    // button that does nothing
                    
                    
                }label: {
                    
                }
                Spacer()
            }
            .onChange(of: SelectedphotoPicker){
                Task{
                    if let data = try? await SelectedphotoPicker?.loadTransferable(type: Data.self),
                       let changeImage = UIImage(data: data) {
                        SelectedTodayImage = Image(uiImage: changeImage)
                    }
                }
            }
            .font(.custom("Caacupe One", size: 25))
        }
    }
}

#Preview {
    UserEntryView()
}
