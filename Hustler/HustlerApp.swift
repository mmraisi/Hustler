//
//  HustlerApp.swift
//  Hustler
//
//  Created by Mahmoud Mraisi on 19/03/2023.
//

import SwiftUI
import Firebase
import FirebaseCore
@main
struct HustlerApp: App {
    init(){
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            MainView()   }
    }
}
