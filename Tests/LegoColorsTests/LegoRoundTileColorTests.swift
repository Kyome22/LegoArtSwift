//
//  LegoRoundTileColorTests.swift
//  
//
//  Created by Takuto Nakamura on 2022/04/06.
//

@testable import LegoColors
import XCTest
import SwiftUI

class LegoRoundTileColorTests: XCTestCase {
    func testLegoRoundTileColor_SomeColors() {
        let actualWhite = LegoRoundTileColor(r: 1.000, g: 1.000, b: 1.000)
        XCTAssertEqual(actualWhite, LegoRoundTileColor.white)

        let actualBlack = LegoRoundTileColor(r: 0.000, g: 0.000, b: 0.000)
        XCTAssertEqual(actualBlack, LegoRoundTileColor.black)

        let actualRust = LegoRoundTileColor(r: 0.610, g: 0.610, b: 0.610)
        XCTAssertEqual(actualRust, LegoRoundTileColor.lightGray)

        let actualOrange = LegoRoundTileColor(r: 1.000, g: 0.494, b: 0.077)
        XCTAssertEqual(actualOrange, LegoRoundTileColor.orange)

        let actualLime = LegoRoundTileColor(r: 0.649, g: 0.793, b: 0.334)
        XCTAssertEqual(actualLime, LegoRoundTileColor.lime)

        let actualBlue = LegoRoundTileColor(r: 0.002, g: 0.340, b: 0.651)
        XCTAssertEqual(actualBlue, LegoRoundTileColor.blue)

        let actualLavender = LegoRoundTileColor(r: 0.693, g: 0.547, b: 0.751)
        XCTAssertEqual(actualLavender, LegoRoundTileColor.lavender)

        let actualPink = LegoRoundTileColor(r: 1.000, g: 0.754, b: 0.794)
        XCTAssertEqual(actualPink, LegoRoundTileColor.pink)
    }

    func testLegoRoundTileColor_initOnNative() {
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
