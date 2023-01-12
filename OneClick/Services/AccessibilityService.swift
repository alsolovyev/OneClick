//
//  AccessibilityService.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 01.01.2023.
//

import Foundation
import Cocoa

class AccessibilityService {
    public var isPermitted: Bool = AXIsProcessTrusted()
    
    static let shared = AccessibilityService()
    
    private init() {
        checkPermission()
    }
    
    public func checkPermission() {
        if (isPermitted) { return }
        
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        isPermitted = AXIsProcessTrustedWithOptions(options)
    }
}
