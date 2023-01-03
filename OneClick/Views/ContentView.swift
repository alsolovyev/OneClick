//
//  ContentView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lowPower: LowPowerViewModel = LowPowerViewModel()
    
    var body: some View {
        VStack {
            Button("Enter Full Screen") {
                WindowManagerService.shared.enterFullScreen()
            }
            
            Button("\(lowPower.isEnabled ? "Disable" : "Enable") low power mode") {
                lowPower.isEnabled ? lowPower.disable() : lowPower.enable()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
