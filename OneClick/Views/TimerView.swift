//
//  TimerView.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 12.01.2023.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var userDefaults: UserDefaultsViewModel
    
    @StateObject var timer: TimerViewModel = TimerViewModel()
    
    public let durations: [Int] = [1, 5, 10, 15, 30, 45, 60]
    
    var body: some View {
        OneClickSwitch(
            title:  "\(timer.isRunning ? "Stop" : "Start") \(userDefaults.timerDuration!) Minute Timer",
            subtitle: timer.timeLeft,
            isEnabled: timer.isRunning,
            icon: timer.isRunning ? "pause.fill" : "play.fill"
        ) {
            timer.isRunning ? timer.stop() : timer.start(duration: userDefaults.timerDuration)
        }.contextMenu{
            if !timer.isRunning {
                ForEach(durations, id: \.self) { t in
                    Button("Set timer for \(t) min") {
                        userDefaults.SetTimerDuration(t)
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
