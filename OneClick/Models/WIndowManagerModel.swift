//
//  WIndowManagerModel.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 04.01.2023.
//

import Foundation

struct WindowManagerModel {
    struct Frame {
        var x: CGFloat
        var y: CGFloat
        var width: CGFloat?
        var height: CGFloat?
        
        var point: CGPoint {
            get {
                return CGPoint(x: x, y: y)
            }
        }
        
        var size: CGSize? {
            get {
                if (width == nil && height == nil) {
                    return nil
                }
                
                return CGSize(width: width!, height: height!)
            }
        }
    }
    
    struct Positions {
        var fullScreen: Frame = Frame(x: 0, y: 0)
        var center: Frame = Frame(x: 0, y: 0)
        var leftTwoThirds: Frame = Frame(x: 0, y: 0)
        var rightOneThird: Frame = Frame(x: 0, y: 0)
        
        func get(_ name: Position) -> Frame {
            switch name {
            case .fullScreen: return fullScreen
            case .center: return center
            case .leftTwoThirds: return leftTwoThirds
            case .rightOneThird: return rightOneThird
            }
        }
    }
    
    enum Position {
        case fullScreen
        case center
        case leftTwoThirds
        case rightOneThird
    }
}
