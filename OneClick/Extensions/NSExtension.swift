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
            
            adjustedFrame.origin.x += Constants.Window.gap
            adjustedFrame.origin.y += menuBarSize + Constants.Window.gap
            adjustedFrame.size.width -= Constants.Window.gap * 2
            adjustedFrame.size.height -= Constants.Window.gap * 2
            
            return adjustedFrame
        }
    }
}
