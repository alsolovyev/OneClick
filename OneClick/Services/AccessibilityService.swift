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
    
    public func checkPermission() -> Bool {
        if (isPermitted) {
            return true
        }
        
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        isPermitted = AXIsProcessTrustedWithOptions(options)
        
        return isPermitted
    }
}
