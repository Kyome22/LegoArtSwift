//
//  LegoColorTests.swift
//
//
//  Created by Takuto Nakamura on 2022/04/06.
//

@testable import LegoColors
import XCTest
import SwiftUI

final class LegoColorTests: XCTestCase {
    func testRGBAfromCGColor() {
        let color = CGColor(srgbRed: 0.12, green: 0.34, blue: 0.56, alpha: 0.78)
        XCTAssertEqual(color.colorSpace?.name, CGColorSpace.sRGB)

        let actual = color.rgba
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual?.r, 0.12)
        XCTAssertEqual(actual?.g, 0.34)
        XCTAssertEqual(actual?.b, 0.56)
    }

    func testLegoColor_diff() {
        let legoColor = SolidColors[5]
        let actual = legoColor.diff(red: 0.12, green: 0.34, blue: 0.56)
        XCTAssertEqual(actual, 0.521)
    }

    func testLegoColor_compare() {
        XCTContext.runActivity(named: "Equal") { _ in
            let legoColorA = SolidColors[3]
            let legoColorB = SolidColors[3]
            XCTAssertTrue(legoColorA == legoColorB)
        }
        XCTContext.runActivity(named: "Not equal") { _ in
            let legoColorA = SolidColors[3]
            let legoColorB = SolidColors[5]
            XCTAssertFalse(legoColorA == legoColorB)
        }
    }
}
