//
//  SettingsView.swift
//  Journaly
//
//  Created by David Adekunle on 07/12/2024.
//

import SwiftUI
import SwiftData
import PhotosUI
import UserNotifications

//authenticating faceID
import LocalAuthentication

struct SettingsView: View {
    @State var nameTxt : String = ""
    @Binding var backgroundColor: Color
    @State var settingBlurToggle : Bool
    @State var enableFaceID = false
    @State var notificationToggle = false
    @State var icloudSyncToggle = false
    @State var lockToggle = 4
    @State var userAvatar : UIImage?
    @State var photosPicker : PhotosPickerItem?
    //var JournalWrapped
    @Environment(\.modelContext) var modelContext
    @Query var settingsModel: [SettingsModel]
    @State var deleteAllJournalConfirm = false
    //@Bindable var settingsManager: SettingsModel

    var body: some View {

            NavigationStack {
                //Color.blue.ignoresSafeArea(.all)

                    List {

                        Section {
                            VStack(alignment: .center) {

                                //photos picker for user's profile
                                PhotosPicker(selection: $photosPicker, matching: .images) {

                                    if let avatar = userAvatar{
                                        Image(uiImage: avatar)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                        //.font(.system(size: 100))
                                            .shadow(radius: 4)
                                            .clipShape(Circle())
                                    }else{
                                        Image(systemName: "person.crop.circle.badge.plus")
                                            .font(.system(size: 100))
                                            .foregroundStyle(.fill)
                                            .background(.ultraThinMaterial.opacity(0))
                                            .shadow(radius: 4)
                                    }
                                }




                                if !nameTxt.isEmpty{
                                    Text(nameTxt)
                                        .font(.largeTitle)
                                        .bold()
                                }else{
                                    Text("Name")
                                        .font(.largeTitle)
                                        .bold()
                                }


                                Text("Manage your name, background images and Color, journals and more.")
                                    .multilineTextAlignment(.center)
                                //.padding(.top, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical)
                            .listRowBackground(Color.clear)
                            .onChange(of: photosPicker){ _, _ in

                                Task{
                                    if let photosPicker,
                                       let data = try? await photosPicker.loadTransferable(type: Data.self){
                                        if let image = UIImage(data: data){
                                            userAvatar = image

                                            if let existing = settingsModel.first {
                                                existing.userPhoto = image.jpegData(compressionQuality: 0.8)
                                                try? modelContext.save()
                                            }
                                        }
                                    }
                                    photosPicker = nil
                                }

                            }
                        }
                        .listRowBackground(Color.blue)

                        Section(header: Text("Name")) {
                            HStack {
                                Image(systemName: "lanyardcard")
                                TextField("Your name", text: $nameTxt)
                            }


                        }

                        Section(header: Text("Backgrounds")) {
                            HStack {
                                Image(systemName: "circle.dotted")
                                    .frame(width: 30)
                                    .foregroundStyle(.secondary)


                                Toggle(isOn: $settingBlurToggle){
                                    Text("Enable Blur")
                                }
                            }
// TODO: BackgroundPickerView not yet implemented
//                            NavigationLink(destination: BackgroundPickerView(backgroundColor: $backgroundColor)) {
//                                HStack {
//                                    Image(systemName: "squareshape.dotted.squareshape")
//                                        .frame(width: 30)
//                                        .foregroundStyle(.secondary)
//                                    Text("Journal Backgrounds")
//                                }
//                            }
                        }

                        Section(header: Text("Privacy")){
                            HStack {
                                Image(systemName: "faceid")
                                //.frame(width: 40)
                                    .font(.title2)
                                    .foregroundStyle(.fill)
                                    .background(.ultraThinMaterial.opacity(0))
                                    .padding(.trailing,10)


                                Toggle(isOn: $enableFaceID){
                                    Text("Enable Face ID")
                                        .font(.body)
                                }
                            }

                            HStack {
                                Image(systemName: "bell.badge")
                                //.frame(width: 40)
                                    .font(.title2)
                                    .foregroundStyle(.fill)
                                    .background(.ultraThinMaterial.opacity(0))
                                    .padding(.trailing,10)


                                Toggle(isOn: $notificationToggle){
                                    Text("Daily Reminder")
                                        .font(.body)
                                }
                            }

//                            HStack {
//                                Image(systemName: "icloud")
//                                //.frame(width: 40)
//                                    .font(.title2)
//                                    .foregroundStyle(.fill)
//                                    .background(.ultraThinMaterial.opacity(0))
//                                    .padding(.trailing,10)
//
//
//                                Toggle(isOn: $icloudSyncToggle){
//                                    Text("iCloud Sync")
//                                        .font(.body)
//                                }
//                            }

                            HStack {
                                Image(systemName: "lock.app.dashed")
                                //.frame(width: 40)
                                    .font(.title2)
                                    .foregroundStyle(.fill)
                                    .background(.ultraThinMaterial.opacity(0))
                                    .padding(.trailing,10)



                                Picker(selection: $lockToggle, label: Text("Auto Lock after")) {
                                    Text("1 min").tag(1)
                                    Text("5 min").tag(2)
                                    Text("10 min").tag(3)
                                    Text("Never").tag(4)
                                }
                                // .defaultWheelPickerItemHeight(30)



                            }

                        }

//                        Section(header: Text(".Misc")){
//                            NavigationLink(destination: JournalyWrapped()) {
//                                HStack {
//                                    Image(systemName: "timelapse")
//                                        .frame(width: 30)
//                                        .foregroundStyle(.secondary)
//                                    Text("Journal Wrapped")
//                                    
//                                    Text(" *coming Soon")
//                                }
//                                .opacity(0.3)
//                            }
//
//
//                        }

                        Section(header: Text("Danger Zone")){
                            Button{
                                deleteAllJournalConfirm = true
                            }label: {
                                HStack {
                                    Image(systemName: "trash")
                                        .frame(width: 30)
                                    Text("Delete all Journals")
                                }
                                .foregroundStyle(.red)
                            }
                            .alert("Delete all Journals",isPresented: $deleteAllJournalConfirm) {
                                
                                Button(role: .destructive){
                                    delAllJournal()
                                } label: {
                                    Text("Delete")
                                }
                                
                                Button("Cancel", role: .cancel){}
//                                message: {Text("This action will Permanently delete all of your Jounrals")}
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    //.background(Color.blue)
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                    .onAppear{
                        if let existing = settingsModel.first {
                            nameTxt = existing.userName
                            enableFaceID = existing.faceIDEnabled
                            notificationToggle = existing.notificationsEnabled
                            if let avatarData = existing.userPhoto {
                                userAvatar = UIImage(data: avatarData)
                            }
                        } else {
                            let newSettings = SettingsModel(userName: "", settinBlurToggle: true)
                            modelContext.insert(newSettings)
                            try? modelContext.save()
                        }
                    }
                    .onChange(of: nameTxt){ oldName, newName in
                        if let existing = settingsModel.first {
                            existing.userName = newName
                            try? modelContext.save()
                        }
                    }
                    .onChange(of: enableFaceID) { oldValue, newValue in
                        if newValue {
                            verifyAndEnableFaceID()
                        } else {
                            saveFaceIDSetting(enabled: false)
                        }
                    }
                    .onChange(of: notificationToggle) { oldValue, newValue in
                        if newValue {
                            scheduleDailyReminder()
                        } else {
                            cancelDailyReminder()
                        }
                    }
                }
    }


    func verifyAndEnableFaceID() {
        let laContext = LAContext()
        var error: NSError?

        guard laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            enableFaceID = false
            return
        }

        laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to enable Face ID") { success, _ in
            DispatchQueue.main.async {
                if success {
                    saveFaceIDSetting(enabled: true)
                } else {
                    enableFaceID = false
                }
            }
        }
    }

    func saveFaceIDSetting(enabled: Bool) {
        if let existing = settingsModel.first {
            existing.faceIDEnabled = enabled
            try? modelContext.save()
        }
    }
    
    func scheduleDailyReminder() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                guard granted else {
                    notificationToggle = false
                    return
                }
                let content = UNMutableNotificationContent()
                content.title = "Time to Journal"
                content.body = "Take a moment to write about your day."
                content.sound = .default

                var dateComponents = DateComponents()
                dateComponents.hour = settingsModel.first?.notificationHour ?? 20
                dateComponents.minute = settingsModel.first?.notificationMinute ?? 0

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)

                if let existing = settingsModel.first {
                    existing.notificationsEnabled = true
                    try? modelContext.save()
                }
            }
        }
    }

    func cancelDailyReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
        if let existing = settingsModel.first {
            existing.notificationsEnabled = false
            try? modelContext.save()
        }
    }

    // TODO: implement when JournalModel is available
    func delAllJournal() {
//        do {
//            try modelContext.delete(model: JournalModel.self)
//            try modelContext.save()
//        } catch {
//            print ("Failed to delete all Journals : \(error)")
//        }
    }
}

#Preview {
    SettingsView(backgroundColor: .constant(.blue), settingBlurToggle: true)
}

struct ListView: View{
    var body: some View{
        HStack{
            Image(systemName: "person.crop.circle")
            Text("Name")
        }
    }
}
