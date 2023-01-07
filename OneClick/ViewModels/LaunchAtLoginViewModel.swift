//
//  LaunchAtLoginViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 07.01.2023.
//

import SwiftUI
import ServiceManagement

class LaunchAtLogin: ObservableObject {
    @Published var isEnabled: Bool

    init() {
        isEnabled = SMAppService.mainApp.status == .enabled
    }
    
    public func toggle() -> Void {
        isEnabled ? disable() : enable()
    }
    
    public func enable() -> Void {
        do {
            try SMAppService.mainApp.register()
            isEnabled = true
        } catch { }
    }
    
    public func disable() -> Void {
        do {
            try SMAppService.mainApp.unregister()
            isEnabled = false
        } catch { }
        
    }
}
