//
//  LegoBrickColorTests.swift
//  
//
//  Created by Takuto Nakamura on 2022/04/06.
//

@testable import LegoColors
import XCTest
import SwiftUI

class LegoBrickColorTests: XCTestCase {
    func testLegoBrickColor_SomeColors() {
        let actualWhite = LegoBrickColor(r: 1.000, g: 1.000, b: 1.000)
        XCTAssertEqual(actualWhite, LegoBrickColor.white)

        let actualBlack = LegoBrickColor(r: 0.000, g: 0.000, b: 0.000)
        XCTAssertEqual(actualBlack, LegoBrickColor.black)

        let actualRust = LegoBrickColor(r: 0.700, g: 0.133, b: 0.136)
        XCTAssertEqual(actualRust, LegoBrickColor.rust)

        let actualOrange = LegoBrickColor(r: 1.000, g: 0.494, b: 0.077)
        XCTAssertEqual(actualOrange, LegoBrickColor.orange)

        let actualLime = LegoBrickColor(r: 0.649, g: 0.793, b: 0.334)
        XCTAssertEqual(actualLime, LegoBrickColor.lime)

        let actualAqua = LegoBrickColor(r: 0.709, g: 0.829, b: 0.840)
        XCTAssertEqual(actualAqua, LegoBrickColor.aqua)

        let actualViolet = LegoBrickColor(r: 0.200, g: 0.284, b: 0.644)
        XCTAssertEqual(actualViolet, LegoBrickColor.violet)

        let actualPink = LegoBrickColor(r: 1.000, g: 0.754, b: 0.794)
        XCTAssertEqual(actualPink, LegoBrickColor.pink)
    }

    func testLegoBrickColor_initOnNative() {
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
