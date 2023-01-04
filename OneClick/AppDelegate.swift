//
//  AppDelegate.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        _ = AccessibilityService.shared.checkPermission()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "heart.fill", accessibilityDescription: "OneClick")
            statusButton.action = #selector(togglePopover)
        }
        
        popover = NSPopover()
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: MainMenuView())
        // Hide arrow
        popover.setValue(true, forKeyPath: "shouldHideAnchor")
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        
    }
}

