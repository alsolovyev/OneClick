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
        isEnabled = getStatus()
    }
    
    func getStatus() -> Bool {
        do {
            let output = try "pmset -g | grep lowpowermode".runScript()
            return output.contains("1")
        } catch {
            return false
        }
    }
    
    func enable() -> Void {
        do {
            _ = try "pmset -a lowpowermode 1".runScript(true)
            isEnabled = true
        } catch { }
    }
    
    func disable() -> Void {
        do {
            _ = try "pmset -a lowpowermode 0".runScript(true)
            isEnabled = false
        } catch { }
    }
}
