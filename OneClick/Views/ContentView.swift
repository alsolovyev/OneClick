//
//  ContentView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lowPower: LowPowerViewModel = LowPowerViewModel()
    
    let test = Color("Border")
    
    var body: some View {
        //        Grid(alignment: .leading, verticalSpacing: 9) {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 9) {
                OneClickButton(title: "Enter Full Screen", icon: "rectangle.fill") {
                    WindowManagerService.shared.moveTo(.fullScreen)
                }
                
                OneClickButton(title: "Left Two Thirds", icon: "rectangle.fill") {
                    WindowManagerService.shared.moveTo(.leftTwoThirds)
                }
                
                OneClickButton(title: "Right One Third", icon: "rectangle.fill") {
                    WindowManagerService.shared.moveTo(.rightOneThird)
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
        .background(EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
        .background(EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
    }
}

struct OneClickButton: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .resizable()
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 16.0, height: 16.0)
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 60.0)
            }
            .frame(width: 70, height: 62)
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
        .background(EffectsView(material: NSVisualEffectView.Material.popover, blendingMode: NSVisualEffectView.BlendingMode.behindWindow))
    }
}

struct EffectsView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
