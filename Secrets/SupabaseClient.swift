//
//  SupabaseClient.swift
//  DoToday
//
//  Created by David Adekunle on 28/10/2026.
//

import Foundation
import Supabase

// supabase client
let Supabase = SupabaseClient(supabaseURL: URL(string: SupaSecret.projectURL)!, supabaseKey: SupaSecret.apiKey)
