//
//  SupabaseClient.swift
//  DoToday
//
//  Created by David Adekunle on 28/10/2026.
//

import Foundation
import Supabase

// supabase client
let supabase = SupabaseClient(supabaseURL: SupaSecret.projectURL, supabaseKey: SupaSecret.apiKey)
