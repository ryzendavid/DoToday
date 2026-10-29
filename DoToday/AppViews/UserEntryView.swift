//
//  UserEntryView.swift
//  DoToday-iphone
//
//  Created by David Adekunle on 17/09/2026.
//

import SwiftUI
import PhotosUI
import SwiftData

struct UserEntryView: View {
    
    @State private var txtField = ""
    @State private var SelectedphotoPicker : PhotosPickerItem?
    @State private var SelectedTodayImage : Image?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    //State to dismiss keyboard
    @FocusState private var isFocused : Bool
    
    //context (swift data)
    @Environment(\.modelContext) var context
    
    @State var entry :[DailyEntry] = []
    
    var body: some View {
        NavigationStack{
            VStack{
//                Text("Hey, *Name what did you do today that made you happy")
                
                TextField("Describe what you did in a few phrases", text: $txtField, axis: .vertical)
                    .padding()
                    .lineLimit(5)
                    .scrollDismissesKeyboard(.immediately)
                    .focused($isFocused)
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard){
                            Spacer()
                                Button{
                                    isFocused = false
                                }label: {
                                    Text("Done")
                                }.buttonStyle(.glassProminent)
                            
                        }
                    }
                
                
                //add this to the button
                
                PhotosPicker(selection: $SelectedphotoPicker, matching: .images){
                    if let TodayImage = SelectedTodayImage{
                        TodayImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            .frame(width: .infinity, height: 310)
                            
                            
                            
                    }else{
                        VStack{
                            Text("Did you get any photos? add them here")
                                .foregroundStyle(Color.primary)
                            
                            Image(systemName: "photo.badge.plus")
                                .font(.system(size: 150))
                                .padding()
                        }
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
            .padding()
            .onChange(of: SelectedphotoPicker){
                Task{
                    if let data = try? await SelectedphotoPicker?.loadTransferable(type: Data.self),
                       let changeImage = UIImage(data: data) {
                        SelectedTodayImage = Image(uiImage: changeImage)
                    }
                }
            }
            .font(.custom("Caacupe One", size: 25))
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel", role: .cancel){
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save Entry"){
                        
                    }
                    .buttonStyle(.glassProminent)
                }
            }
            .font(.custom("Caacupe One", size: 25))
        }
    }
    
    //save/upload entry
    
    func saveEntry() {
        
    }
}

#Preview {
    UserEntryView()
}
