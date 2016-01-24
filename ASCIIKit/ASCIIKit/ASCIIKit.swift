//
//  ASCIIKit.swift
//  ASCIIKit
//
//  Created by 闻端 on 16/1/22.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import Foundation
import UIKit

private extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
}

public extension UIImage{
    private func createARGBBitmapContext() -> CGContext {
        
        let inImage = self.CGImage!
        let pixelsWide = CGImageGetWidth(inImage)
        let pixelsHigh = CGImageGetHeight(inImage)
        
        let bitmapBytesPerRow = Int(pixelsWide) * 4
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapData = UnsafeMutablePointer<UInt8>()
        let bitmapInfo = CGImageAlphaInfo.PremultipliedFirst.rawValue
        
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, bitmapInfo)!
        
        return context
    }
    
    func ASCIIGenerateColorfulMatrixWithSingleCharacter(character:Character, pixelsPerSymbol: Int, completion:(attributedString:NSAttributedString)->Void){
        assert(pixelsPerSymbol > 0, "pixelsPerSymbol invalid value")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let inImage:CGImageRef = self.CGImage!
            let context = self.createARGBBitmapContext()
            let pixelsWide = CGImageGetWidth(inImage)
            let pixelsHigh = CGImageGetHeight(inImage)
            let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
            
            CGContextClearRect(context, rect)
            CGContextDrawImage(context, rect, inImage)
            
            let data = CGBitmapContextGetData(context)
            let dataType = UnsafeMutablePointer<UInt8>(data)
            let mutableAttributedString = NSMutableAttributedString()
            
            let WideBlockCount = pixelsWide / pixelsPerSymbol
            let HighBlockCount = pixelsHigh / pixelsPerSymbol
            for var y = 0; y < Int(HighBlockCount); ++y{
                for var x = 0; x < Int(WideBlockCount) ; ++x {
                    var totalR = 0
                    var totalG = 0
                    var totalB = 0
                    var totalA = 0
                    for var j = 0; j < pixelsPerSymbol; ++j{
                        for var k = 0; k < pixelsPerSymbol; ++k{
                            let currentOffset = 4*((Int(pixelsWide) * Int(y * pixelsPerSymbol + k)) + Int(x * pixelsPerSymbol + j))
                            let alpha = dataType[currentOffset]
                            let red = dataType[currentOffset+1]
                            let green = dataType[currentOffset+2]
                            let blue = dataType[currentOffset+3]
                            totalR += Int(red)
                            totalG += Int(green)
                            totalB += Int(blue)
                            totalA += Int(alpha)
                        }
                    }
                    let avgR = totalR / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgG = totalG / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgB = totalB / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgA = totalA / (pixelsPerSymbol * pixelsPerSymbol)
                    if(avgA != 0){
                        let certainColor = UIColor(red: avgR, green: avgG, blue: avgB, alpha: avgA)
                        let certainText = NSAttributedString(string: String(character), attributes: [NSForegroundColorAttributeName: certainColor])
                        mutableAttributedString.appendAttributedString(certainText)
                    }else{
                        let certainText = NSAttributedString(string: " ")
                        mutableAttributedString.appendAttributedString(certainText)
                    }
                }
                let lineBreak = NSAttributedString(string: "\n")
                mutableAttributedString.appendAttributedString(lineBreak)
            }
            mutableAttributedString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(8), NSKernAttributeName: 4.4], range: NSMakeRange(0, mutableAttributedString.length))
            CGContextClearRect(context, rect)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(attributedString: mutableAttributedString)
            })
        }
        
    }
    
    func ASCIIGenerateGrayScaleMatrixWithSingleCharacter(character:Character, pixelsPerSymbol: Int, completion:(attributedString:NSAttributedString)->Void){
        assert(pixelsPerSymbol > 0, "pixelsPerSymbol invalid value")
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //            // do some task
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                // update some UI
        //                });
        //            });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let inImage:CGImageRef = self.CGImage!
            let context = self.createARGBBitmapContext()
            let pixelsWide = CGImageGetWidth(inImage)
            let pixelsHigh = CGImageGetHeight(inImage)
            let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
            
            CGContextClearRect(context, rect)
            CGContextDrawImage(context, rect, inImage)
            
            let data = CGBitmapContextGetData(context)
            let dataType = UnsafeMutablePointer<UInt8>(data)
            let mutableAttributedString = NSMutableAttributedString()
            
            let WideBlockCount = pixelsWide / pixelsPerSymbol
            let HighBlockCount = pixelsHigh / pixelsPerSymbol
            for var y = 0; y < Int(HighBlockCount); ++y{
                for var x = 0; x < Int(WideBlockCount) ; ++x {
                    var totalR = 0
                    var totalG = 0
                    var totalB = 0
                    var totalA = 0
                    for var j = 0; j < pixelsPerSymbol; ++j{
                        for var k = 0; k < pixelsPerSymbol; ++k{
                            let currentOffset = 4*((Int(pixelsWide) * Int(y * pixelsPerSymbol + k)) + Int(x * pixelsPerSymbol + j))
                            let alpha = dataType[currentOffset]
                            let red = dataType[currentOffset+1]
                            let green = dataType[currentOffset+2]
                            let blue = dataType[currentOffset+3]
                            totalR += Int(red)
                            totalG += Int(green)
                            totalB += Int(blue)
                            totalA += Int(alpha)
                        }
                    }
                    let avgR = totalR / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgG = totalG / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgB = totalB / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgGrayScale = (avgR + avgG + avgB) / 3
                    let avgA = totalA / (pixelsPerSymbol * pixelsPerSymbol)
                    if(avgA != 0){
                        let certainColor = UIColor(white: CGFloat(avgGrayScale) / 255.0, alpha: CGFloat(avgA) / 255.0)
                        let certainText = NSAttributedString(string: String(character), attributes: [NSForegroundColorAttributeName: certainColor])
                        mutableAttributedString.appendAttributedString(certainText)
                    }else{
                        let certainText = NSAttributedString(string: " ")
                        mutableAttributedString.appendAttributedString(certainText)
                    }
                }
                let lineBreak = NSAttributedString(string: "\n")
                mutableAttributedString.appendAttributedString(lineBreak)
            }
            mutableAttributedString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(8), NSKernAttributeName: 4.4], range: NSMakeRange(0, mutableAttributedString.length))
            CGContextClearRect(context, rect)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(attributedString: mutableAttributedString)
            })
        }
        
    }
    func ASCIIGenerateGrayScaleMatrixWithMultipleCharacter(pixelsPerSymbol: Int, completion:(attributedString:NSAttributedString)->Void){
        assert(pixelsPerSymbol > 0, "pixelsPerSymbol invalid value")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let inImage:CGImageRef = self.CGImage!
            let context = self.createARGBBitmapContext()
            let pixelsWide = CGImageGetWidth(inImage)
            let pixelsHigh = CGImageGetHeight(inImage)
            let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
            
            CGContextClearRect(context, rect)
            CGContextDrawImage(context, rect, inImage)
            
            let data = CGBitmapContextGetData(context)
            let dataType = UnsafeMutablePointer<UInt8>(data)
            let mutableAttributedString = NSMutableAttributedString()
            
            let WideBlockCount = pixelsWide / pixelsPerSymbol
            let HighBlockCount = pixelsHigh / pixelsPerSymbol
            for var y = 0; y < Int(HighBlockCount); ++y{
                for var x = 0; x < Int(WideBlockCount) ; ++x {
                    var totalR = 0
                    var totalG = 0
                    var totalB = 0
                    var totalA = 0
                    for var j = 0; j < pixelsPerSymbol; ++j{
                        for var k = 0; k < pixelsPerSymbol; ++k{
                            let currentOffset = 4*((Int(pixelsWide) * Int(y * pixelsPerSymbol + k)) + Int(x * pixelsPerSymbol + j))
                            let alpha = dataType[currentOffset]
                            let red = dataType[currentOffset+1]
                            let green = dataType[currentOffset+2]
                            let blue = dataType[currentOffset+3]
                            totalR += Int(red)
                            totalG += Int(green)
                            totalB += Int(blue)
                            totalA += Int(alpha)
                        }
                    }
                    let avgR = totalR / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgG = totalG / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgB = totalB / (pixelsPerSymbol * pixelsPerSymbol)
                    let avgGrayScale = (avgR + avgG + avgB) / 3
                    let avgA = totalA / (pixelsPerSymbol * pixelsPerSymbol)
                    if(avgA != 0){
                        let certainText = NSAttributedString(string: avgGrayScale.convertToASCIICharacter())
                        mutableAttributedString.appendAttributedString(certainText)
                    }else{
                        let certainText = NSAttributedString(string: " ")
                        mutableAttributedString.appendAttributedString(certainText)
                    }
                }
                let lineBreak = NSAttributedString(string: "\n")
                mutableAttributedString.appendAttributedString(lineBreak)
            }
            mutableAttributedString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(8), NSKernAttributeName: 4.4], range: NSMakeRange(0, mutableAttributedString.length))
            CGContextClearRect(context, rect)

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(attributedString: mutableAttributedString)
            })
        }

    }

}

private extension Int{
    func convertToASCIICharacter()->String{
        let level = self * 9 / 255
        let returnValue:String = {
            switch level{
            case 0:
                return "@"
            case 1:
                return "#"
            case 2:
                return "&"
            case 3:
                return "8"
            case 4:
                return "o"
            case 5:
                return ":"
            case 6:
                return "*"
            case 7:
                return "~"
            case 8:
                return "."
            default:
                return " "
            }
        }()
        return returnValue
    }
}

//MARK: convert NSAttributedString to UIImage
public extension NSAttributedString{
    func generateImage()->UIImage{
        let textLayer = CATextLayer()
        textLayer.string = self
        let rect = self.boundingRectWithSize(textLayer.frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        textLayer.frame = rect
        textLayer.contentsScale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
//        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 1, 1, 1, 1)
//        CGContextFillRect(UIGraphicsGetCurrentContext(), rect)
        textLayer.drawInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}




