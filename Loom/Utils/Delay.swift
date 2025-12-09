//
//  Delay.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation

// Custom class to make it easier to delay a function/task
class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    // Default value in case a delay is not given
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        
        // Converts the given function to a DispatchWorkItem
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        // Add the converted DispatchWorkitem to delay into the DispatchQueue
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    // Function to cancel the delay in case the user changes their mind about executing a function
    func cancel() {
        workItem?.cancel()
    }
}
