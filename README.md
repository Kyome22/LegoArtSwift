# LegoArtFilter

Generates an image that looks like LEGO Art.
This library supports both iOS (14≤) and macOS (11≤).

## Usage

```swift
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
//                 (round/round plate/square/square plate)
// maxStud:        Determines the maximum bricks number of the generated image.
// studPixelWidth: Specifies the pixel width of the actual brick to be drawn.
let legoArt = LegoArt(ciImage: CIImage,
                      baseColor: CGColor,
                      studType: StudType,
                      maxStud: Int,
                      studPixelWidth: Int)
```

## LICENSE

Copyright (c) 2021 Takuto NAKAMURA (Kyome)

You are free to use it as long as it is not for commercial use.
