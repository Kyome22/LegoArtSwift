import XCTest
import SwiftUI
@testable import LegoColors

final class LegoColorsTests: XCTestCase {
    func testRGBAfromCGColor() {
        let color = CGColor(srgbRed: 0.12, green: 0.34, blue: 0.56, alpha: 0.78)
        XCTAssertEqual(color.colorSpace?.name, CGColorSpace.sRGB)

        let actual = color.rgba
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual?.r, 0.12)
        XCTAssertEqual(actual?.g, 0.34)
        XCTAssertEqual(actual?.b, 0.56)
    }

    func testLegoColorBlack() {
        let actual = LegoColor(r: 0, g: 0, b: 0)
        XCTAssertEqual(actual, LegoColor.black)
    }

    func testLegoColorWhite() {
        let actual = LegoColor(r: 1, g: 1, b: 1)
        XCTAssertEqual(actual, LegoColor.white)
    }

    func testLegoSomeColors() {
        let actualRust = LegoColor(r: 0.700, g: 0.133, b: 0.136)
        XCTAssertEqual(actualRust, LegoColor.rust)

        let actualOrange = LegoColor(r: 1.000, g: 0.494, b: 0.077)
        XCTAssertEqual(actualOrange, LegoColor.orange)

        let actualLime = LegoColor(r: 0.649, g: 0.793, b: 0.334)
        XCTAssertEqual(actualLime, LegoColor.lime)

        let actualAqua = LegoColor(r: 0.709, g: 0.829, b: 0.840)
        XCTAssertEqual(actualAqua, LegoColor.aqua)

        let actualViolet = LegoColor(r: 0.200, g: 0.284, b: 0.644)
        XCTAssertEqual(actualViolet, LegoColor.violet)

        let actualPink = LegoColor(r: 1.000, g: 0.754, b: 0.794)
        XCTAssertEqual(actualPink, LegoColor.pink)
    }

    func testLegoColorInitOnNative() {
#if canImport(UIKit)
        let uc = UIColor(red: 0.949, green: 0.717, blue: 0.254, alpha: 1.0)
        let actual = LegoColor(uiColor: uc)
        XCTAssertEqual(LegoColor.brightLightOrange, actual)
#elseif canImport(AppKit)
        let nc = NSColor(red: 0.949, green: 0.717, blue: 0.254, alpha: 1.0)
        let actual = LegoColor(nsColor: nc)
        XCTAssertEqual(LegoColor.brightLightOrange, actual)
#endif
    }
}
