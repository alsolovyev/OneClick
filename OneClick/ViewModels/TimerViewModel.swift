//
//  TimerViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 11.01.2023.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var isRunning: Bool = false
    @Published var timeLeft: String = "00:00"
    
    public let timers: [Int] = [1, 5, 10, 15, 30, 45, 60]
    
    private var timer: Timer? = nil
    private var duration: Int = 0
    private var time: Int = 0
    
    public func start(duration: Int) {
        if isRunning { return }
        
        self.duration = duration * 60
        self.isRunning = true
            
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc func tick() {
        time += 1
        
        if NSApplication.shared.isActive {
            timeLeft = formatTime(duration - time)
        }
        
        if time == duration {
            NotificationService.shared.show(title: "Hey!", subtitle: "Timer is over")
            stop()
        }
    }
    
    public func stop() {
        if !isRunning { return }
        
        timer!.invalidate()
        timer = nil
        
        time = 0
        timeLeft = formatTime(0)
        isRunning = false
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: TimeInterval(seconds))!
    }
}


