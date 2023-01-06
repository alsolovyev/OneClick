//
//  LowPowerViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 03.01.2023.
//

import Foundation

class LowPowerViewModel: ObservableObject {
    @Published public var isEnabled: Bool = false
    
    init() {
        getStatus()
    }
    
    func getStatus() -> Void {
        do {
            try "pmset -g | grep lowpowermode".runScript() { out in
                self.isEnabled = out.contains("1")
            }
        } catch { }
    }
    
    func enable() -> Void {
        do {
            try "pmset -a lowpowermode 1".runScript(true) { out in
                self.isEnabled = true
            }
        } catch { }
    }
    
    func disable() -> Void {
        do {
            try "pmset -a lowpowermode 0".runScript(true) { _ in
                self.isEnabled = false
            }
        } catch { }
    }
    
    func toggle() {
        isEnabled ? disable() : enable()
    }
}
