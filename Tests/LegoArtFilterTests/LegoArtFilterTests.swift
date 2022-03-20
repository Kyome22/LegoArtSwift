import XCTest
@testable import LegoArtFilter

final class LegoArtFilterTests: XCTestCase {
    
    func testLegoArtInitWithCIImage() {
#if os(iOS)
        let uiImage = UIImage(named: "Ginkgo", in: Bundle.module, compatibleWith: nil)
        XCTAssertNotNil(uiImage)
        
        let actual = LegoArtFilter(from: uiImage!)
        XCTAssertNotNil(actual)
#elseif os(macOS)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("Ginkgo"))
        XCTAssertNotNil(nsImage)
        
        let actual = LegoArtFilter(from: nsImage!)
        XCTAssertNotNil(actual)
#endif
    }
    
    func testLegoArtExportCGImage() {
#if os(iOS)
        let uiImage = UIImage(named: "Ginkgo", in: Bundle.module, compatibleWith: nil)
        XCTAssertNotNil(uiImage)
        
        let legoArtFilter = LegoArtFilter(from: uiImage!)
        XCTAssertNotNil(legoArtFilter)
#elseif os(macOS)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("Ginkgo"))
        XCTAssertNotNil(nsImage)
        
        let legoArtFilter = LegoArtFilter(from: nsImage!)
        XCTAssertNotNil(legoArtFilter)
#endif
        let cgImage = legoArtFilter!.exportCGImage()
        XCTAssertNotNil(cgImage)
        XCTAssertEqual(cgImage!.width, (48 * 11 - 1))
    }
}
