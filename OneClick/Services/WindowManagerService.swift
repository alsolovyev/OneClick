//
//  WindowViewModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

class WindowViewModel: ObservableObject {
    private var screenSize: CGSize = CGSize(width: 0, height: 0)
    
    static let shared = WindowViewModel()
    
    private init() {
        getScreenSize()
    }
    
    func enterFullScreen() {
        let focusedWindow: AXUIElement? = getFocusedWindow()
        
        guard focusedWindow != nil else {
            return
        }
        
        var position : CFTypeRef
        var size : CFTypeRef
        var newPoint = CGPoint(x: 19, y: 44 + 19)
        var newSize = CGSize(width: screenSize.width - 19 * 2, height: screenSize.height - 19 * 2)
        

        position = AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!,&newPoint)!
        AXUIElementSetAttributeValue(focusedWindow!, NSAccessibility.Attribute.position.rawValue as CFString, position)
        
        size = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!,&newSize)!;
        AXUIElementSetAttributeValue(focusedWindow!, NSAccessibility.Attribute.size.rawValue as CFString, size);
    }
    
    private func getScreenSize() {
        let size: CGSize? = NSScreen.main?.visibleFrame.size
        screenSize = size!
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
