//
//  LegoSquareTileColorTests.swift
//  
//
//  Created by Takuto Nakamura on 2022/04/06.
//

@testable import LegoColors
import XCTest
import SwiftUI

class LegoSquareTileColorTests: XCTestCase {
    func testLegoSquareTileColor_SomeColors() {
        let actualWhite = LegoSquareTileColor(r: 1.000, g: 1.000, b: 1.000)
        XCTAssertEqual(actualWhite, LegoSquareTileColor.white)

        let actualBlack = LegoSquareTileColor(r: 0.000, g: 0.000, b: 0.000)
        XCTAssertEqual(actualBlack, LegoSquareTileColor.black)

        let actualRust = LegoSquareTileColor(r: 0.610, g: 0.610, b: 0.610)
        XCTAssertEqual(actualRust, LegoSquareTileColor.lightGray)

        let actualOrange = LegoSquareTileColor(r: 1.000, g: 0.494, b: 0.077)
        XCTAssertEqual(actualOrange, LegoSquareTileColor.orange)

        let actualLime = LegoSquareTileColor(r: 0.649, g: 0.793, b: 0.334)
        XCTAssertEqual(actualLime, LegoSquareTileColor.lime)

        let actualBlue = LegoSquareTileColor(r: 0.002, g: 0.340, b: 0.651)
        XCTAssertEqual(actualBlue, LegoSquareTileColor.blue)

        let actualLavender = LegoSquareTileColor(r: 0.693, g: 0.547, b: 0.751)
        XCTAssertEqual(actualLavender, LegoSquareTileColor.lavender)

        let actualPink = LegoSquareTileColor(r: 1.000, g: 0.754, b: 0.794)
        XCTAssertEqual(actualPink, LegoSquareTileColor.pink)
    }

    func testLegoSquareTileColor_initOnNative() {
#if canImport(UIKit)
        let uc = UIColor(red: 0.949, green: 0.717, blue: 0.254, alpha: 1.0)
        let actual = LegoBrickColor(uiColor: uc)
        XCTAssertEqual(actual, LegoBrickColor.brightLightOrange)
#elseif canImport(AppKit)
        let nc = NSColor(red: 0.949, green: 0.717, blue: 0.254, alpha: 1.0)
        let actual = LegoBrickColor(nsColor: nc)
        XCTAssertEqual(actual, LegoBrickColor.brightLightOrange)
#endif
    }
}
