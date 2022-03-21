import XCTest
@testable import LegoArtFilter

final class LegoArtFilterTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func printPartsList(partsList: [PartsData]) {
        partsList.forEach({ pd in
            Swift.print("\(pd.legoColor.name): \(pd.quantity)")
        })
    }

    func testInitWithCIImage() {
        let url = Bundle.module.url(forResource: "ginkgo", withExtension: "jpg")
        XCTAssertNotNil(url)
        let ciImage = CIImage(contentsOf: url!)
        XCTAssertNotNil(ciImage)
        let actual = LegoArtFilter(ciImage: ciImage!)
        XCTAssertNotNil(actual)
    }

    func testInitWithUIImage() throws {
#if canImport(UIKit)
        let uiImage = UIImage(named: "ginkgo.jpg", in: Bundle.module, compatibleWith: nil)
        XCTAssertNotNil(uiImage)
        let actual = LegoArtFilter(from: uiImage!)
        XCTAssertNotNil(actual)
#else
        throw XCTSkip("can not import UIKit")
#endif
    }

    func testInitWithNSImage() throws {
#if canImport(AppKit)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("ginkgo.jpg"))
        XCTAssertNotNil(nsImage)
        let actual = LegoArtFilter(from: nsImage!)
        XCTAssertNotNil(actual)
#else
        throw XCTSkip("can not import AppKit")
#endif
    }

    func testExportCGImage() throws {
        let url = Bundle.module.url(forResource: "ginkgo", withExtension: "jpg")!
        let ciImage = CIImage(contentsOf: url)!
        let legoArtFilter = LegoArtFilter(ciImage: ciImage)!
        let actual = legoArtFilter.exportCGImage()
        XCTAssertNotNil(actual)
        XCTAssertEqual(actual!.width, (48 * 11 - 1))
    }

    func testPartsList() {
        let url = Bundle.module.url(forResource: "ginkgo", withExtension: "jpg")!
        let ciImage = CIImage(contentsOf: url)!
        let legoArtFilter = LegoArtFilter(ciImage: ciImage)!
        let actual = legoArtFilter.partsList
        printPartsList(partsList: actual)
        XCTAssertEqual(actual.count, 49)
    }
}
