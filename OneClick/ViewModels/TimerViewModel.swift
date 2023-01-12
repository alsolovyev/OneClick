//
//  TimerViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 11.01.2023.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var isRunning: Bool = false
    
    public let timers: [Int] = [1, 5, 10, 15, 30, 45, 60]
    
    private var timer: Timer? = nil
    
    public func start(duration: Double) {
        if isRunning { return }
            
        timer = Timer(timeInterval: duration * 60, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: .common)

        isRunning = true
    }
    
    @objc func tick() {
        NotificationService.shared.show(title: "Hey!", subtitle: "Timer is over")
        stop()
    }
    
    public func stop() {
        if !isRunning { return }
        
        timer!.invalidate()
        timer = nil
        
        isRunning = false
    }
}


