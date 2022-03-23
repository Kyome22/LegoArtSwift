//
//  File.swift
//  
//
//  Created by Takuto Nakamura on 2022/03/24.
//

import LegoColors

public struct PartsData {
    public let legoColor: LegoColor
    public var quantity: Int

    init(legoColor: LegoColor) {
        self.legoColor = legoColor
        self.quantity = 1
    }

    mutating func countUp() {
        quantity += 1
    }
}
