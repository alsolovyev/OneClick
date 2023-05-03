//
//  Constants.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

// TODO: Add shortcuts configuration view

import Foundation
import KeyboardShortcuts

struct Constants {
    struct Window {
        static let gap: CGFloat = 24
    }
}

extension KeyboardShortcuts.Name {
    static let toFullScreen = Self("toFullScreen", default: .init(.k, modifiers: [.command, .option]))
    static let toHalfLeft = Self("toHalfLeft", default: .init(.h, modifiers: [.command, .option]))
    static let toHalfRight = Self("toHalfRight", default: .init(.l, modifiers: [.command, .option]))
    static let toNineTenthsLeft = Self("toNineTenthsLeft", default: .init(.j, modifiers: [.command, .option]))
}
