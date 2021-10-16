import XCTest
@testable import LegoArtFilter

final class LegoArtFilterTests: XCTestCase {
    
    func testLegoArtInitWithCIImage() {
#if os(iOS)
        let uiImage = UIImage(named: "Ginkgo", in: Bundle.module, compatibleWith: nil)
        XCTAssertNotNil(uiImage)
        
        let actual = LegoArt(from: uiImage!)
        XCTAssertNotNil(actual)
#elseif os(macOS)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("Ginkgo"))
        XCTAssertNotNil(nsImage)
        
        let actual = LegoArt(from: nsImage!)
        XCTAssertNotNil(actual)
#endif
    }
    
    func testLegoArtExportCGImage() {
#if os(iOS)
        let uiImage = UIImage(named: "Ginkgo", in: Bundle.module, compatibleWith: nil)
        XCTAssertNotNil(uiImage)
        
        let legoArt = LegoArt(from: uiImage!)
        XCTAssertNotNil(legoArt)
#elseif os(macOS)
        let nsImage = Bundle.module.image(forResource: NSImage.Name("Ginkgo"))
        XCTAssertNotNil(nsImage)
        
        let legoArt = LegoArt(from: nsImage!)
        XCTAssertNotNil(legoArt)
#endif
        let cgImage = legoArt!.exportCGImage()
        XCTAssertNotNil(cgImage)
        XCTAssertEqual(cgImage!.width, (48 * 11 - 1))
    }
}
