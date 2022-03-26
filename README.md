# LegoArtSwift

Provides utilities to create your own LEGO Art.

## LegoArtFilter

Generates an image that looks like LEGO Art.<br/>
This library supports both iOS (14+) and macOS (11+).

### Usage

```swift
// Get CGImage from CIImage
let input = CIImage()
if let legoArtFilter = LegoArtFilter(ciImage: input) {
    let output = legoArtFilter.exportCGImage()
}

// Get UIImage from UIImage
let input = UIImage()
if let legoArtFilter = LegoArtFilter(from: input) {
    let output = legoArtFilter.exportUIImage()
}

// Get NSImage from NSImage
let input = NSImage()
if let legoArtFilter = LegoArtFilter(from: input) {
    let output = legoArtFilter.exportNSImage()
}

// Use the options
// baseColor:      It is used as a base for transparent images such as PNG.
// StudType:       It is reflected in the appearance of the brick.
//                 (round/round plate/square/square plate)
// maxStud:        Determines the maximum bricks number of the generated image.
// studPixelWidth: Specifies the pixel width of the actual brick to be drawn.
let legoArtFilter = LegoArtFilter(ciImage: CIImage,
                                  baseColor: CGColor,
                                  studType: StudType,
                                  maxStud: Int,
                                  studPixelWidth: Int)
```

### Demo

`LegoArtSwiftDemo.xcodeproj` is a demonstration of LegoArtFilter in the Examples directory.
You can build it Xcode.app (ver 13+).

#### iOS

<img src="Screenshots/screenshot_ios.png" height="250px" />

#### macOS

<img src="Screenshots/screenshot_macos.png" height="250px" />

## LegoColors

A library to make it easier to handle the colors of LEGO blocks with Swift.<br/>
This library supports both iOS (14+) and macOS (11+).

### Usage

```swift
// Get CGColor from name of a brick.
let color = LegoColor.darkTurquoise.color

// Get an approximate LegoColor from CGColor
let cgColor = CGColor(srgbRed: 0.12, green: 0.34, blue: 0.56, alpha: 1.0)
let legoColor = LegoColor(cgColor: cgColor)

// Get an approximate LegoColor from UIColor or NSColor.
let legoColor = LegoColor(uiColor: UIColor.blue)
let legoColor = LegoColor(nsColor: NSColor.yellow)
```

Note: `LegoColor` refers to [Color Guid of Bricklink](https://www.bricklink.com/catalogColors.asp).

## LICENSE

Copyright (c) 2021 Takuto NAKAMURA (Kyome)

You are free to use it as long as it is not for commercial use.
