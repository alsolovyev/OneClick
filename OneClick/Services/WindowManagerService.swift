//
//  WindowViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

class WindowManagerService: ObservableObject {
    static let shared = WindowManagerService()
    
    func enterFullScreen() {
        if (!AccessibilityService.shared.isPermitted) {
            return
        }
        
        let focusedWindow: AXUIElement? = getFocusedWindow()
        
        guard focusedWindow != nil else {
            return
        }
        
        let visibleFrame = NSScreen.main!.adjustedVisibleFrame
        
        var leftTopPoint = CGPoint(x: visibleFrame.origin.x, y: visibleFrame.origin.y)
        let newPosition: CFTypeRef = AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!,&leftTopPoint)!
        AXUIElementSetAttributeValue(focusedWindow!, NSAccessibility.Attribute.position.rawValue as CFString, newPosition)

        var size = CGSize(width: visibleFrame.size.width, height: visibleFrame.size.height)
        let newSize = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!,&size)!
        AXUIElementSetAttributeValue(focusedWindow!, NSAccessibility.Attribute.size.rawValue as CFString, newSize)
    }
    
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
        
        //Get frontmost application windows
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
