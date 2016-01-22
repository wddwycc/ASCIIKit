<p align="middle"><img src="icon.png"/></p>
---




How to use
---
Drag `ASCIIKit.xcodeproj` into your project and add it into `Embedded Binaries`


Original Image:  
![](demo/original Image.jpg)

To generate ASCII single character colorful matrix:

    testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
      let image = attributedString.generateImage()
    }
![](demo/1.png)

To generate ASCII single character grey scale matrix:

    testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter("#", pixelsPerSymbol: 2) { (attributedString) -> Void in
      let image = attributedString.generateImage()
    }
![](demo/2.png)


To generate ASCII multi character grey scale matrix:

        testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter(symbol, pixelsPerSymbol: 2) { (attributedString) -> Void in
          let image = attributedString.generateImage()
        }


![](demo/3.png)



See more detail in the demo project~.
