//
//  Functions.swift
//  DoToday
//
//  Created by David Adekunle on 28/10/2026.
//

import Foundation
import Supabase
import SwiftUI

func delEntry(id: UUID) async throws{
    do {
        try await supabase.database
            .from("entries")
            .delete()
            .eq("id", value: id)
            .execute()
    } catch{
        print("Failed to delete this entry, please try again later : \(error)")
    }
}


