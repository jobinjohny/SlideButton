//
//  SlideButton.swift
//  SlideButton
//
//  Created by Jobin on 18/04/20.
//  Copyright © 2020 Jobin_Johny. All rights reserved.
//

import Foundation
import UIKit

protocol SlideButtonDelegate {
    func buttonStatus(status:String, sender:PanicSlidingButton)
}

@IBDesignable class PanicSlidingButton: UIView {
    
    var delegate: SlideButtonDelegate?
    
    @IBInspectable var dragPointWidth: CGFloat = 40 {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var dragPointColor: UIColor = ApplicationColour.UIColorFromRGB(rgbValue: 0xfebd27) {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var buttonColor: UIColor = ApplicationColour.UIColorFromRGB(rgbValue: 0xfebd27) {
        didSet{
            setStyle()
        }
    }
    
    var swipeText: String = "Swipe for"
    var panicButtonText: String = "Slide Button" {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var imageName: UIImage = UIImage() {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var buttonTextColor: UIColor = UIColor.white {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var dragPointTextColor: UIColor = UIColor.white {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var buttonUnlockedTextColor: UIColor = UIColor.white {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var buttonCornerRadius: CGFloat = 24 {
        didSet{
            setStyle()
        }
    }
    
    @IBInspectable var buttonUnlockedText: String   = "Panic Button"
    @IBInspectable var buttonUnlockedColor: UIColor = UIColor.black
    var panicButtonFont                                  = UIFont.boldSystemFont(ofSize: 16)
    var swipeButtonFont                                  = UIFont.systemFont(ofSize: 13)
    
    
    var dragPoint            = UIView()
    var swipeForLabel          = UILabel()
    var panicButtonLabel = UILabel()
    var imageView            = UIImageView()
    var unlocked             = false
    var layoutSet            = false
    var angleImageOne: UIImageView!
    var angleImageTwo: UIImageView!
    var angleImageThree: UIImageView!
    var circularView: UIView!
    let arrowImageName = "arrow"
    var imageArray = Array<UIImageView>()
    var numberOfImage: Int!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func layoutSubviews() {
        if !layoutSet{
            self.setUpButton()
            self.layoutSet = true
        }
    }
    
    func setStyle(){
        self.swipeForLabel.text               = self.panicButtonText
        self.panicButtonLabel.text      = self.panicButtonText
        self.dragPoint.frame.size.width     = self.dragPointWidth
        self.dragPoint.backgroundColor      = self.dragPointColor
        self.backgroundColor                = self.buttonColor
        self.imageView.image                = imageName
        self.swipeForLabel.textColor          = self.buttonTextColor
        self.panicButtonLabel.textColor = self.dragPointTextColor
        
        self.dragPoint.layer.cornerRadius   = buttonCornerRadius
        self.layer.cornerRadius             = buttonCornerRadius
    }
    
    private func addCircularViewToDragPoint() {
        let buttonHieghtDeduction = 20.0 as CGFloat
        let yAxixDeduction = buttonHieghtDeduction/2
        circularView = UIView(frame: CGRect(x: self.dragPoint.frame.width - (buttonHieghtDeduction + 15), y: self.dragPoint.frame.origin.y + yAxixDeduction, width: self.dragPoint.frame.height - buttonHieghtDeduction, height: self.dragPoint.frame.height - buttonHieghtDeduction))
        circularView.backgroundColor = .white
        circularView.layer.cornerRadius = circularView.frame.height/2
        // border
        self.circularView.layer.borderWidth = 0
        self.circularView.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        self.circularView.layer.shadowColor = UIColor.black.cgColor
        self.circularView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.circularView.layer.shadowOpacity = 0.2
        self.circularView.layer.shadowRadius = circularView.layer.cornerRadius
        
        self.dragPoint.addSubview(circularView)
        self.addThreeArrowsToMainViewRight()
        self.addArrowToTheSwipeView()
    }
    
    private func addThreeArrowsToMainViewRight() {
        let bufferSpace = 50.0 as CGFloat
        let inbetweenSpace = 25 as CGFloat
        let imageSize = 24.0 as CGFloat
        let yAxix = (self.frame.height - imageSize) / 2
        angleImageThree = UIImageView(frame: CGRect(x: self.frame.width - bufferSpace, y: yAxix, width: imageSize, height: imageSize))
        angleImageThree.image = UIImage(named: arrowImageName)
        self.addSubview(angleImageThree)
        
        angleImageTwo = UIImageView(frame: CGRect(x: angleImageThree.frame.origin.x - ( inbetweenSpace), y: yAxix, width: imageSize, height: imageSize))
        angleImageTwo.image = UIImage(named: arrowImageName)
        self.addSubview(angleImageTwo)
        
        angleImageOne = UIImageView(frame: CGRect(x: angleImageTwo.frame.origin.x - ( inbetweenSpace), y: yAxix, width: imageSize, height: imageSize))
        angleImageOne.image = UIImage(named: arrowImageName)
        self.addSubview(angleImageOne)
        animateInitialArrows()
    }
    
    func animateInitialArrows() {
        guard (angleImageOne != nil && angleImageTwo != nil && angleImageThree != nil) else {
            return
        }
        animateWithKeyframes(dotToAnimate: angleImageOne, delay: 0.0)
        animateWithKeyframes(dotToAnimate: angleImageTwo, delay: 0.3)
        animateWithKeyframes(dotToAnimate: angleImageThree, delay: 0.6)
        animateSwipeView()
    }
    
    private func addArrowToTheSwipeView() {
        let swipeViewWidth = self.dragPoint.frame.width
        let buttonbuffer = 30 as CGFloat
        let imageSize = 24.0 as CGFloat
        let inbetweenSpace = 29 as CGFloat
        let yAxix = (self.frame.height - imageSize) / 2
        let avaliableWidth = swipeViewWidth - (dragPointWidth + buttonbuffer + inbetweenSpace + buttonbuffer)
        numberOfImage = Int(avaliableWidth/imageSize)
        imageArray.removeAll()
        for i in 0...numberOfImage {
            var imageView: UIImageView!
            if(imageArray.isEmpty) {
                imageView = UIImageView(frame: CGRect(x: circularView.frame.origin.x - buttonbuffer, y: yAxix, width: imageSize, height: imageSize))
                imageView.image = UIImage(named: arrowImageName)
                self.dragPoint.addSubview(imageView)
                imageArray.append(imageView)
            } else {
                let previousView = imageArray[i-1]
                imageView = UIImageView(frame: CGRect(x: previousView.frame.origin.x - (inbetweenSpace), y: yAxix, width: imageSize, height: imageSize))
                imageView.image = UIImage(named: arrowImageName)
                self.dragPoint.addSubview(imageView)
                imageArray.append(imageView)
            }
        }
        animateSwipeView()
    }
    
    func animateSwipeView() {
        guard (numberOfImage != nil && imageArray.count != 0) else {
            return
        }
        var duration = (0.3 * Double(numberOfImage))*2
        for i in  0...numberOfImage {
            duration = duration/2
            animateWithKeyframes(dotToAnimate: imageArray[i], delay: duration, duration: 2)
        }
    }
    
    func setUpButton(){
        
        self.backgroundColor              = self.buttonColor
        
        self.dragPoint                    = UIView(frame: CGRect(x: dragPointWidth - self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.dragPoint.backgroundColor    = dragPointColor
        self.dragPoint.layer.cornerRadius = buttonCornerRadius
        self.addSubview(self.dragPoint)
        self.addCircularViewToDragPoint()
        
        if !self.panicButtonText.isEmpty{
            let bufferWidth = 10.0 as CGFloat
            self.swipeForLabel               = UILabel(frame: CGRect(x:dragPointWidth + bufferWidth, y: bufferWidth, width: self.frame.size.width, height: 13))
            self.swipeForLabel.textAlignment = .left
            self.swipeForLabel.text          = swipeText
            self.swipeForLabel.textColor     = UIColor.white
            self.swipeForLabel.font          = self.swipeButtonFont
            self.swipeForLabel.textColor     = self.buttonTextColor
            self.addSubview(self.swipeForLabel)
            let panicBtnY = (swipeForLabel.frame.origin.y + swipeForLabel.frame.height + 2) as CGFloat
            self.panicButtonLabel               = UILabel(frame: CGRect(x: dragPointWidth + bufferWidth, y: panicBtnY, width: self.frame.size.width, height: 17))
            self.panicButtonLabel.textAlignment = .left
            self.panicButtonLabel.text          = panicButtonText
            self.panicButtonLabel.textColor     = UIColor.white
            self.panicButtonLabel.font          = self.panicButtonFont
            self.panicButtonLabel.textColor     = self.dragPointTextColor
            self.addSubview(self.panicButtonLabel)
        }
        self.bringSubviewToFront(self.dragPoint)
        
        if self.imageName != UIImage(){
            self.imageView = UIImageView(frame: CGRect(x: self.frame.size.width - dragPointWidth, y: 0, width: self.dragPointWidth, height: self.frame.size.height))
            self.imageView.contentMode = .center
            self.imageView.image = self.imageName
            self.dragPoint.addSubview(self.imageView)
        }
        
        self.layer.masksToBounds = true
        
        // start detecting pan gesture
        let panGestureRecognizer                    = UIPanGestureRecognizer(target: self, action: #selector(self.panDetected(sender:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.dragPoint.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panDetected(sender: UIPanGestureRecognizer){
        var translatedPoint = sender.translation(in: self)
        translatedPoint     = CGPoint(x: translatedPoint.x, y: self.frame.size.height / 2)
        sender.view?.frame.origin.x = (dragPointWidth - self.frame.size.width) + translatedPoint.x
        if sender.state == .ended{
            
            let velocityX = sender.velocity(in: self).x * 0.2
            var finalX    = translatedPoint.x + velocityX
            if finalX < 0{
                finalX = 0
            }else if finalX + self.dragPointWidth  >  (self.frame.size.width - 60){
                unlocked = true
                self.unlock()
            }
            
            let animationDuration:Double = abs(Double(velocityX) * 0.0002) + 0.2
            UIView.transition(with: self, duration: animationDuration, options: UIView.AnimationOptions.curveEaseOut, animations: {
            }, completion: { (Status) in
                if Status{
                    self.animationFinished()
                }
            })
        }
    }
    
    func animationFinished(){
        if !unlocked{
            self.reset()
        }
    }
    
    //lock button animation (SUCCESS)
    func unlock(){
        UIView.transition(with: self, duration: 0.2, options: .curveEaseOut, animations: {
            self.dragPoint.frame = CGRect(x: self.frame.size.width - self.dragPoint.frame.size.width, y: 0, width: self.dragPoint.frame.size.width, height: self.dragPoint.frame.size.height)
        }) { (Status) in
            if Status{
                self.panicButtonLabel.text      = self.buttonUnlockedText
                self.imageView.isHidden               = true
                //                self.dragPoint.backgroundColor      = self.buttonUnlockedColor
                self.panicButtonLabel.textColor = self.buttonUnlockedTextColor
                //TODO: Remove
                self.reset()
                self.delegate?.buttonStatus(status: "Unlocked", sender: self)
            }
        }
    }
    
    //reset button animation (RESET)
    func reset(){
        UIView.transition(with: self, duration: 0.2, options: .curveEaseOut, animations: {
            self.dragPoint.frame = CGRect(x: self.dragPointWidth - self.frame.size.width, y: 0, width: self.dragPoint.frame.size.width, height: self.dragPoint.frame.size.height)
        }) { (Status) in
            if Status{
                self.panicButtonLabel.text      = self.panicButtonText
                self.imageView.isHidden               = false
                self.dragPoint.backgroundColor      = self.dragPointColor
                self.panicButtonLabel.textColor = self.dragPointTextColor
                self.unlocked                       = false
                //self.delegate?.buttonStatus("Locked")
            }
        }
    }
    
    private func animateWithKeyframes(dotToAnimate:UIView, delay:Double, duration: TimeInterval = 1.5) {
        UIView.animateKeyframes(
            withDuration: duration,
            delay: delay,
            options: [UIView.KeyframeAnimationOptions.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.33333333333,
                    animations: {
                        //                        dotToAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        dotToAnimate.alpha = 0
                }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.33333333333,
                    relativeDuration: 0.66666666667,
                    animations: {
                        //                        dotToAnimate.transform = CGAffineTransform.identity
                        dotToAnimate.alpha = 1
                }
                )
        }
        )
    }
}

