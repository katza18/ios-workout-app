//
//  WorkoutTimer.swift
//  Workout
//
//  Created by Aidan Katz on 8/17/23.
//

import Foundation
import SwiftUI

class WorkoutTimer: ObservableObject {
    @Published var seconds = 0
    @Published var formattedTime = "00:00"
    private var timer: Timer?
    
    var isRunning: Bool {
        timer != nil
    }
    
    func start() {
        if !isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                self.seconds += 1
                self.updateFormattedTime()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        seconds = 0
        formattedTime = "00:00"
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateFormattedTime() {
        let min = seconds / 60
        let sec = seconds % 60
        self.formattedTime = String(format: "%02d:%02d", min, sec)
    }
    
    deinit {
        stop()
    }
    
}
