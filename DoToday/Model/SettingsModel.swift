//
//  SettingsModel.swift
//  Journaly
//
//  Created by David Adekunle on 06/04/2025.
//

import Foundation
import SwiftData
import Observation

@Model
class SettingsModel {
    var userName : String = ""
    var settinBlurToggle = true
    var faceIDEnabled: Bool = false
    var userPhoto : Data?
    var notificationsEnabled: Bool = false
    var notificationHour: Int = 20
    var notificationMinute: Int = 0

    init(userName: String, settinBlurToggle: Bool, faceIDEnabled: Bool = false) {
        self.userName = userName
        self.settinBlurToggle = settinBlurToggle
        self.faceIDEnabled = faceIDEnabled
        self.userPhoto = userPhoto
    }
}
