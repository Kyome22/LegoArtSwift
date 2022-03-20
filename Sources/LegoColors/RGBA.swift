//
//  LGBA.swift
//
//
//  Created by Takuto Nakamura on 2021/10/14.
//

import CoreGraphics

public struct RGBA {
    public let r: CGFloat
    public let g: CGFloat
    public let b: CGFloat
    public let a: CGFloat

    public var strength: CGFloat {
        return r + g + b
    }
}
