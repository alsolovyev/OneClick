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
    
    private var positions: WindowManagerModel.Positions = WindowManagerModel.Positions()
    
    init() {
        getPositions()
    }
    
    func moveTo(_ position: WindowManagerModel.Position) {
        if (!AccessibilityService.shared.isPermitted) {
            return
        }
        
        let focusedWindow: AXUIElement? = getFocusedWindow()
        
        guard focusedWindow != nil else {
            return
        }
        
        let newPosition = positions.get(position)

        focusedWindow!.setValue(.position, newPosition.point.toAXValue())
        
        guard newPosition.size != nil else { return }
        focusedWindow!.setValue(.size, newPosition.size!.toAXValue())
    }
}

extension WindowManagerService {
    private func getPositions() {
        let frame = NSScreen.main?.adjustedVisibleFrame
        
        let minX = frame!.origin.x + Constants.Window.gap
        let minY = frame!.origin.y + Constants.Window.gap
        let maxWidth = frame!.size.width - Constants.Window.gap * 2
        let maxHeight = frame!.size.height - Constants.Window.gap * 2
        let twoThirdsWidth = maxWidth * 2 / 3
        let oneThirdWidth = maxWidth / 3
        
        positions.fullScreen = WindowManagerModel.Frame(
            x: minX,
            y: minY,
            width: maxWidth,
            height: maxHeight
        )
        
        positions.center = WindowManagerModel.Frame(
            x: maxWidth / 2,
            y: maxWidth / 2
        )
        
        positions.leftTwoThirds = WindowManagerModel.Frame(
            x: minX,
            y: minY,
            width: twoThirdsWidth - Constants.Window.gap,
            height: maxHeight
        )
        
        positions.rightOneThird = WindowManagerModel.Frame(
            x: twoThirdsWidth + Constants.Window.gap,
            y: minY,
            width: oneThirdWidth,
            height: maxHeight
        )
    }
}

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
