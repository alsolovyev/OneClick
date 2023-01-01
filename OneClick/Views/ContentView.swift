//
//  ContentView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Enter Full Screen") {
                WindowManagerService.shared.enterFullScreen()
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
