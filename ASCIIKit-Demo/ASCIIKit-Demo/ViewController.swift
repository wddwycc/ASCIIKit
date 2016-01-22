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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var currentLevel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    var currentValue = 4
    var currentState = 0
    
    var symbol = "#" as Character
    
    
    var attributedString:NSAttributedString?
    
    
    var presentedVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testImage = UIImage(named: "test.jpg")!
        testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter(symbol, pixelsPerSymbol: 4) { (attributedString) -> Void in
            self.attributedString = attributedString
            self.imageView.image = attributedString.generateImage()
        }
        self.indicator.hidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapImage")
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(tapGesture)
        
        
        
    }
    func didTapImage(){
        let vc = UIViewController()
        self.presentedVC = vc
        vc.view.backgroundColor = UIColor.whiteColor()
        let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        vc.view.addSubview(imageView)
        imageView.image = self.imageView.image
        
        let tapBackGesture = UITapGestureRecognizer(target: self, action: "didTapBack")
        vc.view.addGestureRecognizer(tapBackGesture)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    func didTapBack(){
        self.presentedVC?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didSelectSegment(sender: UISegmentedControl) {
        let testImage = UIImage(named: "test.jpg")!
        self.view.userInteractionEnabled = false
        self.animeShowIndicator()
        self.slider.value = 0.44
        self.currentLevel.text = "4"
        switch sender.selectedSegmentIndex{
        case 0:
            testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter(symbol, pixelsPerSymbol: 4) { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            }
        case 1:
            currentState = 1
            testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter(symbol, pixelsPerSymbol: 4) { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            }
        case 2:
            currentState = 2
            testImage.ASCIIGenerateGrayScaleMatrixWithMultipleCharacter(4, completion: { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            })
        default:
            break
        }
    }
    @IBAction func didSlide(sender: UISlider) {
        let valueNow = Int(sender.value / 0.11) +  1
        if(valueNow != self.currentValue){
            self.currentValue = valueNow
            self.currentLevel.text = "\(valueNow)"
            self.updatePresentation()
        }
    }
    
    
    @IBAction func didSelectUpdateSymbol(sender: UIButton) {
        let alertController = UIAlertController(title: "Switch Symbol", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        let action = UIAlertAction(title: "Go~", style: .Cancel) { (action) -> Void in
            if(alertController.textFields![0].text == nil || alertController.textFields![0].text == ""){
                return
            }
            let text = alertController.textFields![0].text!
            let thatSymbol = text[text.startIndex.advancedBy(0)]
            self.symbol = thatSymbol
            self.updatePresentation()   
        }
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func updatePresentation(){
        let testImage = UIImage(named: "test.jpg")!
        self.view.userInteractionEnabled = false
        self.animeShowIndicator()
        switch currentState{
        case 0:
            testImage.ASCIIGenerateColorfulMatrixWithSingleCharacter(symbol, pixelsPerSymbol: Int(self.currentLevel.text!)!) { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            }
        case 1:
            testImage.ASCIIGenerateGrayScaleMatrixWithSingleCharacter(symbol, pixelsPerSymbol: Int(self.currentLevel.text!)!) { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            }
        case 2:
            testImage.ASCIIGenerateGrayScaleMatrixWithMultipleCharacter(Int(self.currentLevel.text!)!, completion: { (attributedString) -> Void in
                self.attributedString = attributedString
                self.imageView.image = attributedString.generateImage()
                self.view.userInteractionEnabled = true
                self.animeHideIndicator()
            })
        default:
            break
        }
    }
    
    
    
    func animeShowIndicator(){
        self.indicator.hidden = false
        self.indicator.startAnimating()
    }
    func animeHideIndicator(){
        self.indicator.stopAnimating()
        self.indicator.hidden = true
    }
    
    
    
    
}

