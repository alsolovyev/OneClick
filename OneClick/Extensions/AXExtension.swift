//
//  AXExtension.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

import Cocoa


extension AXUIElement {
    func getValue(_ attribute: NSAccessibility.Attribute) -> AnyObject? {
        var value: AnyObject?
        
        let result = AXUIElementCopyAttributeValue(self, attribute.rawValue as CFString, &value)
        guard result == .success else { return nil }
        
        return value
    }
    
    func setValue(_ attribute: NSAccessibility.Attribute, _ value: AnyObject) {
        AXUIElementSetAttributeValue(self, attribute.rawValue as CFString, value)
    }
}
