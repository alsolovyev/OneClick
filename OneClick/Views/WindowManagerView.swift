//
//  WindowManagerView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 06.01.2023.
//

import SwiftUI

struct WindowManagerView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 9) {
                OneClickButton(
                    labelTop: "Enter",
                    labelBottom: "Full Screen",
                    icon: "rectangle.inset.filled"
                ) {
                    WindowManagerService.shared.toFullScreen()
                }
                
                OneClickButton(
                    labelTop: "Left",
                    labelBottom: "Two Thirds",
                    icon: "rectangle.leadinghalf.inset.filled"
                ) {
                    WindowManagerService.shared.toTwoThirdsLeft()
                }
                
                OneClickButton(
                    labelTop: "Right",
                    labelBottom: "One Third",
                    icon: "rectangle.trailingthird.inset.filled"
                ) {
                    WindowManagerService.shared.toOneThirdRight()
                }
                
                OneClickButton(
                    labelTop: "Left",
                    labelBottom: "Nine Tenths",
                    icon: "rectangle.leadinghalf.inset.filled"
                ) {
                    WindowManagerService.shared.toNineTenthsLeft()
                }
            }
        }.frame(width: 240)
    }
}

struct WindowManagerView_Previews: PreviewProvider {
    static var previews: some View {
        WindowManagerView()
    }
}
