//
//  ViewController.swift
//  ASCIIKit-Demo
//
//  Created by 闻端 on 16/1/22.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit
import ASCIIKit
class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let testImage = UIImage(named: "test2.png")!
        let image = testImage
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(imageView)
        imageView.image = image.ASCIIGenerateGrayScaleMatrixWithSingleCharacter("#", pixelsPerSymbol: 6).generateImage()
        
        
    }


}

