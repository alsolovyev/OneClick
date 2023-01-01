//
//  NSExtention.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

import Cocoa

extension NSScreen {
    var adjustedVisibleFrame: CGRect {
        get {
            var adjustedFrame: CGRect = visibleFrame
            
            adjustedFrame.origin.x += 19
            adjustedFrame.origin.y += 44 + 19
            adjustedFrame.size.width -= 19 * 2
            adjustedFrame.size.height -= 19 * 2
            
            return adjustedFrame
        }
    }
}
