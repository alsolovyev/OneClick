//
//  TimerView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 12.01.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: TimerViewModel = TimerViewModel()
    
    @State var timerDuration: Int = 5
    
    var body: some View {
        OneClickSwitch(
            title:  "\(timer.isRunning ? "Stop" : "Start") \(timerDuration) Minute Timer",
            subtitle: timer.timeLeft,
            isEnabled: timer.isRunning,
            icon: timer.isRunning ? "pause.fill" : "play.fill"
        ) {
            timer.isRunning ? timer.stop() : timer.start(duration: timerDuration)
        }.contextMenu{
            if !timer.isRunning {
                ForEach(timer.timers, id: \.self) { t in
                    Button("Set timer for \(t) min") {
                        timerDuration = t
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
