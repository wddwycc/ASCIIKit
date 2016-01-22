<p align="middle"><img src="https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/icon.png"/></p>
---




How to use
---
Drag `ASCIIKit.xcodeproj` into your project and add it into `Embedded Binaries` of your project


Original Image:  
![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/Demo/original Image.jpg)

To generate ASCII single character colorful matrix:

```swift
testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/Demo/1.png)

To generate ASCII single character grey scale matrix:

```swift
testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/Demo/2.png)


To generate ASCII multi character grey scale matrix:

```swift
testImage.ASCIIGenerateGrayScaleMatrixWithMultipleCharacter(pixelsPerSymbol: 2) { (attributedString) -> Void in
    let image = attributedString.generateImage()
}
```

![](https://raw.githubusercontent.com/wddwycc/ASCIIKit/master/Demo/3.png)


The process is done Asynchoriously with CoreGraphics.


See more detail in the demo project~.
