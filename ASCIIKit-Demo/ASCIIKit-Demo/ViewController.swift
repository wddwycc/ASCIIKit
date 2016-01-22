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
        

        let testImage = UIImage(named: "test.png")
        let image = testImage!.ASCIIGenerateColorfulMatrixWithSingleCharacter("#", scaleFactor: 1).generateImage()
        
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(imageView)
        
        imageView.image = image
        
        
    }


}

