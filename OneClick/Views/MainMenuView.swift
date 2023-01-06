//
//  ContentView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

// TODO: - Split code into separate files
// TODO: - Add button styles

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var lowPower: LowPowerViewModel = LowPowerViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
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
            }
            
            VStack(alignment: .leading) {
                OneClickSwitch(
                    title: "Low Power Mode",
                    isEnabled: lowPower.isEnabled,
                    icon: "moon.fill"
                ) {
                    lowPower.isEnabled ? lowPower.disable() : lowPower.enable()
                }
            }
        }
        .padding(9)
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

struct OneClickSwitch: View {
    var title: String
    var isEnabled: Bool
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                ZStack() {
                    Circle()
                        .frame(width: 26, height: 26)
                        .foregroundColor(isEnabled ? .blue : .gray.opacity(0.4))
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 14, height: 14)
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                    Text(isEnabled ? "On" : "Off")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(width: 240, alignment: .leading)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            
        }
        .buttonStyle(.plain)
        .background(.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black.opacity(0.2), lineWidth: 0.5)
                .blur(radius: 1.0)
        )
    }
}

struct OneClickButton: View {
    var labelTop: String
    var labelBottom: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            VStack() {
                Image(systemName: icon)
                    .resizable()
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 19.2, height: 16.0)
                Text(labelTop)
                    .font(.system(size: 9, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 60.0)
                Text(labelBottom)
                    .font(.system(size: 9, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 60.0)
            }
            .frame(width: 70, height: 62)
            .contentShape(Rectangle())
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            
        }
        .buttonStyle(.plain)
        .padding(2)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black.opacity(0.2), lineWidth: 0.5)
                .blur(radius: 1.0)
        )
    }
}
