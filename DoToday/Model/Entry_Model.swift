//
//  Entry_Model.swift
//  DoToday
//
//  Created by David Adekunle on 27/10/2026.
//

import Foundation
import SwiftData
import SwiftUI

@Model

 class Entry_Model : Identifiable{
    var entry_title : String
    var entry_body : String
    //var entry_Image : Image
    var created_at : Date
    var is_complete : Bool
    
//  var is_friend : Bool
    
    
    //initialiser
    
     init(entry_title: String, entry_body: String, entry_Image: Image, created_at : Date, is_complete: Bool) {
        self.entry_title = entry_title
        self.entry_body = entry_body
        //self.entry_Image = entry_Image
        self.created_at = created_at
        self.is_complete = is_complete
    }
}




