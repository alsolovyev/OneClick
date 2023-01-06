//
//  CGExtension.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

import Cocoa


extension CGPoint {
    func toAXValue() -> AXValue {
        var value = self
        return AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!, &value)!
    }
}

extension CGSize {
    func toAXValue() -> AXValue {
        var value = self
        return AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!, &value)!
    }
}

extension CGRect {
    var point: CGPoint {
        get {
            return CGPoint(
                x: self.origin.x,
                y: self.origin.y
            )
        }
    }
}
