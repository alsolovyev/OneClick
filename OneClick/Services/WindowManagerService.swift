//
//  WindowViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import Foundation
import SwiftUI

class WindowManagerService: ObservableObject {
    static let shared = WindowManagerService()
    
    private let mainScreen = NSScreen.main!.adjustedVisibleFrame
    
    func to(position: CGPoint) {
        if (!AccessibilityService.shared.isPermitted) {
            return
        }
        
        let focusedWindow: AXUIElement? = getFocusedWindow()
        
        guard focusedWindow != nil else {
            return
        }
        
        focusedWindow!.setValue(.position, position.toAXValue())
    }
    
    func to(position: CGPoint, size: CGSize) {
        if (!AccessibilityService.shared.isPermitted) {
            return
        }
        
        let focusedWindow: AXUIElement? = getFocusedWindow()
        
        guard focusedWindow != nil else {
            return
        }
        
        focusedWindow!.setValue(.position, position.toAXValue())
        focusedWindow!.setValue(.size, size.toAXValue())
    }
}

// MARK: - Get Focused Window
extension WindowManagerService {
    private func getFocusedWindow() -> AXUIElement? {
        let focusedApp: NSRunningApplication? = NSWorkspace.shared.frontmostApplication
        
        guard focusedApp != nil else {
            return nil
        }
        
        // Check if the app is on the ignore list
        let ignoredApplicationBundleIdentifiers = ["com.apple.finder"]
        guard !ignoredApplicationBundleIdentifiers.contains(focusedApp!.bundleIdentifier!) else {
            return nil
        }
        
        // Get frontmost application windows
        let appRef = AXUIElementCreateApplication(focusedApp!.processIdentifier)
        
        var windows: AnyObject? // NSArray
        let result = AXUIElementCopyAttributeValue(appRef, NSAccessibility.Attribute.windows.rawValue as CFString, &windows)
            
        guard result == .success else {
            return nil
        }
        
        // Check if the position attribute of the specified accessibility object can be changed
        var isSettable = DarwinBoolean(false)
        for window in windows as! Array<AXUIElement> {
            let error = AXUIElementIsAttributeSettable(window, NSAccessibility.Attribute.position.rawValue as CFString, &isSettable)

            guard error == .success else {
                continue
            }
            
            return window
        }
        
        return nil
    }
}


// MARK: - To Full Screen
extension WindowManagerService {
    func toFullScreen() {
        var position = mainScreen.origin
        position.x += Constants.Window.gap
        position.y += Constants.Window.gap
        
        var size = mainScreen.size
        size.width -= Constants.Window.gap * 2
        size.height -= Constants.Window.gap * 2
        
        to(position: position, size: size)
    }
}


// MARK: - Two Thirds to the Left
extension WindowManagerService {
    func toTwoThirdsLeft() {
        var position = mainScreen.origin
        position.x += Constants.Window.gap
        position.y += Constants.Window.gap
        
        var size = mainScreen.size
        size.width = size.width / 3 * 2 - Constants.Window.gap
        size.height -= Constants.Window.gap
        
        to(position: position, size: size)
    }
}

// MARK: - One Third to the Right
extension WindowManagerService {
    func toOneThirdRight() {
        var size = mainScreen.size
        size.width /= 3
        size.height -= Constants.Window.gap
        
        var position = mainScreen.origin
        position.x = mainScreen.width / 3 * 2
        position.y += Constants.Window.gap
        
        to(position: position, size: size)
    }
}

// MARK: - Nine Tenths to the Left
extension WindowManagerService {
    func toNineTenthsLeft() {
        var position = mainScreen.origin
        position.x += Constants.Window.gap
        position.y += Constants.Window.gap
        
        var size = mainScreen.size
        size.width = size.width * 0.91
        size.height -= Constants.Window.gap
        
        to(position: position, size: size)
    }
}
