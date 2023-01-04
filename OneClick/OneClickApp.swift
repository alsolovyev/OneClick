//
//  OneClickApp.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

@main
struct OneClickApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        MenuBarExtra("OneClick", systemImage: "heart.fill") {
            ContentView()
        }.menuBarExtraStyle(.window)
    }
}
