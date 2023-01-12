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
    @ObservedObject var launchAtLogin: LaunchAtLogin = LaunchAtLogin()
    
    var body: some View {
        VStack(alignment: .center) {
            WindowManagerView()
            
            VStack(alignment: .leading) {
                OneClickSwitch(
                    title: "Low Power Mode",
                    isEnabled: lowPower.isEnabled,
                    icon: "bolt.fill"
                ) {
                    lowPower.toggle()
                }
                
                TimerView()
            }
            
            Divider()
                .padding(.vertical)
                .frame(width: 30)
                .opacity(0.5)
            
            HStack(alignment: .center, spacing: 18) {
                Button {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Image(systemName: "power")
                        .foregroundColor(.white.opacity(0.5))
                        .fontWeight(.medium)
                }
                    .buttonStyle(.plain)
                    .help("Quit")
                
                Button {
                    launchAtLogin.toggle()
                } label: {
                    Image(systemName: "pin")
                        .foregroundColor(launchAtLogin.isEnabled ? .blue : .white.opacity(0.5))
                        .fontWeight(.medium)
                }
                    .buttonStyle(.plain)
                    .help("Launch at Login")
            }
            
            
        }
        .padding(9)
        .padding(.bottom, 12)
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

struct OneClickSwitch: View {
    var title: String
    var subtitle: String? = nil
    var isEnabled: Bool
    var icon: String
    var action: () -> Void
    
    init(title: String, subtitle: String, isEnabled: Bool, icon: String, action: @escaping () -> Void ) {
        self.title = title
        self.subtitle = subtitle
        self.isEnabled = isEnabled
        self.icon = icon
        self.action = action
    }
    
    init(title: String, isEnabled: Bool, icon: String, action: @escaping () -> Void ) {
        self.title = title
        self.isEnabled = isEnabled
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                ZStack() {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(isEnabled ? .blue : .gray.opacity(0.4))
                    Image(systemName: icon)
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                    Text(subtitle != nil ? subtitle! : isEnabled ? "On" : "Off")
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
        .cornerRadius(8)
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
                Text(labelBottom)
            }
            .font(.system(size: 9, weight: .medium))
            .lineLimit(1)
            .multilineTextAlignment(.center)
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
