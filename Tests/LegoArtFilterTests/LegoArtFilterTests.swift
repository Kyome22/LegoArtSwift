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

// Get CGImage from CIImage
let input = CIImage()
if let legoArt = LegoArt(ciImage: input) {
    let output = legoArt.exportCGImage()
}

// Get UIImage from UIImage
let input = UIImage()
if let legoArt = LegoArt(from: input) {
    let output = legoArt.exportUIImage()
}

// Get NSImage from NSImage
let input = NSImage()
if let legoArt = LegoArt(from: input) {
    let output = legoArt.exportNSImage()
}

// Use the options
// baseColor:      It is used as a base for transparent images such as PNG.
// StudType:       It is reflected in the appearance of the brick.
//                 (round/roud plate/square/square plate)
// maxStud:        Determines the maximum bricks number of the generated image.
// studPixelWidth: Specifies the pixel width of the actual brick to be drawn.
let legoArt = LegoArt(ciImage: CIImage,
                      baseColor: CGColor,
                      studType: StudType,
                      maxStud: Int,
                      studPixelWidth: Int)
