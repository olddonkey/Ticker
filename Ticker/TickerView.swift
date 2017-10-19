//
//  TickerView.swift
//  Ticker
//
//  Created by olddonkey on 2017/10/10.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let DEFAULT_TEXT_SIZE = 12
    let DEFAULT_TEXT_COLOR = UIColor.black
    let DEFAULT_ANIMATION_DURATION = 0.3
    
    lazy var metrics: TickerDrawMetrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: CGFloat(DEFAULT_TEXT_SIZE)))
    lazy var columnManager = TickerColumnManager(metrics: metrics)
    // Need a animator
    lazy var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: animationDuration, controlPoint1: animationControlPoints[0], controlPoint2: animationControlPoints[1], animations: {
            //Do nothing here
        })
        return animator
    }()
    var viewBounds: CGRect = CGRect()
    
    private var text: String = ""
    
    private var lastMeasuredDesiredWidth: Int = 0
    private var lastMeasuredDesiredHeight: Int = 0
    
    private var gravity: Int = 0
    private var textColor: UIColor = UIColor.black
    private var textSize: CGFloat = 17
    private var textStyle: Int = 0
    private var animationDuration: TimeInterval = 0.3
    private var animateMeasurementChaneg: Bool = false
    private var animationControlPoints: [CGPoint] = [CGPoint(x: 0.1, y: 0.5), CGPoint(x: 0.5, y: 0.2)]
    
    public func setCharacterList(characterList: [Character]) {
        var foundEmpty: Bool = false
        for character in characterList {
            if character == TickerUtils.EMPTY_CHAR {
                foundEmpty = true
                break
            }
        }
        
        if !foundEmpty {
            assertionFailure("No Empty char found in character list")
        }
        
        columnManager.setCharacterList(characterList: characterList)
    }
    
    public func setText(text: String, animate: Bool = true) {
        synchronized(lock: self) {
            if self.text == text {
                return
            }
            
            self.text = text
            var targetText: [Character] = text.count == 0 ? [Character]() : Array(text.characters)
            
            columnManager.setText(text: targetText)
            if animate {
                if animator.isRunning {
                    animator.stopAnimation(true)
                }
                animator.duration = animationDuration
                animator.
            }
        }
    }
    
}
