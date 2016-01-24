<p align="middle"><img src="https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/icon.png"/></p>
---

###ASCIIKit is a powerful framwork to generate ASCII matrix on iOS.


How to install:
---
Drag `ASCIIKit.xcodeproj` into your project and add `ASCIIKit.framework` into `Embedded Binaries` and `Linked frameworks and libraries`

How to Use:
---

Original Image:  
![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/DemoImages/original Image.jpg)  
(from: https://d13yacurqjgara.cloudfront.net/users/60266/screenshots/1974826/open-uri20150316-11-vz33qe_1x)

##### Generate ASCII single character colorful matrix:

```swift
testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/DemoImages/1.png)

##### Generate ASCII single character grey scale matrix:

```swift
testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/DemoImages/2.png)


##### Generate ASCII multi character grey scale matrix:

```swift
testImage.ASCIIGenerateGrayScaleMatrixWithMultipleCharacter(pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/DemoImages/3.png)


The calculation is done Asynchoriously with CoreGraphics.

See more detail in the demo project~.
