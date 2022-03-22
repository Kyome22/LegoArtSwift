import XCTest
@testable import LegoArtFilter

final class LegoArtFilterTests: XCTestCase {

    func printPartsList(partsList: [PartsData]) {
        partsList.forEach({ pd in
            Swift.print("\(pd.legoColor.name): \(pd.quantity)")
        })
    }

    func testInitWithCIImage() throws {
        let url = Bundle.module.url(forResource: "ginkgo", withExtension: "jpg")
        let ciImage = CIImage(contentsOf: try XCTUnwrap(url))
        let actual = LegoArtFilter(ciImage: try XCTUnwrap(ciImage))
        XCTAssertNotNil(actual)
    }

    func testInitWithUIImage() throws {
#if canImport(UIKit)
        let uiImage = UIImage(named: "ginkgo.jpg", in: Bundle.module, compatibleWith: nil)
        let actual = LegoArtFilter(from: try XCTUnwrap(uiImage))
        XCTAssertNotNil(actual)
#else
        throw XCTSkip("can not import UIKit")
#endif
    }

    func testInitWithNSImage() throws {
#if canImport(AppKit)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("ginkgo.jpg"))
        let actual = LegoArtFilter(from: try XCTUnwrap(nsImage))
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
        XCTAssertEqual(actual?.width, (48 * 11 - 1))
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
