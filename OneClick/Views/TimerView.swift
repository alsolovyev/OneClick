//
//  TimerView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 12.01.2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timer: TimerViewModel = TimerViewModel()
    
    @State var duration: Int = 5
    
    public let durations: [Int] = [1, 5, 10, 15, 30, 45, 60]
    
    var body: some View {
        OneClickSwitch(
            title:  "\(timer.isRunning ? "Stop" : "Start") \(duration) Minute Timer",
            subtitle: timer.timeLeft,
            isEnabled: timer.isRunning,
            icon: timer.isRunning ? "pause.fill" : "play.fill"
        ) {
            timer.isRunning ? timer.stop() : timer.start(duration: duration)
        }.contextMenu{
            if !timer.isRunning {
                ForEach(durations, id: \.self) { t in
                    Button("Set timer for \(t) min") {
                        duration = t
                    }
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
