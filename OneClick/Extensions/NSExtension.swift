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
            
            let menuBarSize: CGFloat = 44
            
            adjustedFrame.origin.y += menuBarSize
            
            return adjustedFrame
        }
    }
}
