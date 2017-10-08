//
//  TickerColumn.swift
//  Ticker
//
//  Created by olddonkey on 2017/9/18.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerColumn: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let unknown_start_index = -1
    let unknown_end_index = -2
    
    var characterList: [Character] = [Character]()
    var characterIndicesMap: [Character: Int] = [Character: Int]()
    var metrics: TickerDrawMetrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: 17))
    
    var currentChar: Character = TickerUtils.EMPTY_CHAR
    var targetChar: Character = TickerUtils.EMPTY_CHAR
    
    var startIndex: Int = 0
    var endIndex: Int = 0
    
    var bottomCharIndex: Int = 0
    var bottomDelta: CGFloat = 0
    var charHeight: CGFloat = 0
    
    var sourceWidth: CGFloat = 0
    var currentWidth: CGFloat = 0
    var targetWidth: CGFloat = 0
    var minimumRequiredWidth: CGFloat = 0
    
    var currentBottomDelta: CGFloat = 0
    var previousBottomDelta: CGFloat = 0
    var directionAdjustment: CGFloat = 0
    
    init(characterList: [Character], characterIndicesMap: [Character: Int], metrics: TickerDrawMetrics) {
        super.init(frame: CGRect.zero)
        self.characterList = characterList
        self.characterIndicesMap = characterIndicesMap
        self.metrics = metrics
        //super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTargetChar(targetChar: Character) {
        self.targetChar = targetChar
        self.sourceWidth = self.currentWidth
        self.targetWidth = metrics.getCharWidth(character: targetChar)
        self.minimumRequiredWidth = max(self.sourceWidth, self.targetWidth)
        
        setCharacterIndice()
        
        let scrollDown = endIndex >= startIndex
        directionAdjustment = scrollDown ? 1 : -1
        
        previousBottomDelta = currentBottomDelta
        currentBottomDelta = 0
    }
    
    func getCurrentChar() -> Character {
        return currentChar
    }
    
    func getTargetChar() -> Character {
        return targetChar
    }
    
    func getCurrentWidth() -> CGFloat {
        return currentWidth
    }
    
    func getMinimunRequiredWidth() -> CGFloat {
        return minimumRequiredWidth
    }
    
    func setCharacterIndice() {
        startIndex = characterIndicesMap[currentChar] ?? unknown_start_index
        endIndex = characterIndicesMap[targetChar] ?? unknown_end_index
    }
    
    func onAnimationEnd() {
        minimumRequiredWidth = currentWidth
    }
    
    func setAnimationProgress(animationProgress: CGFloat) {
        /// If animate to the end, then directly set the value
        if animationProgress == 1 {
            currentChar = targetChar
            currentBottomDelta = 0
            previousBottomDelta = 0
        }
        
        let charHeight = metrics.getCharHeight()
        let totalHeight = charHeight*CGFloat(abs(endIndex-startIndex))
        
        let currentBase = animationProgress*totalHeight
        
        let bottomCharPosition = currentBase/charHeight
        
        let bottomCharOffsetPercentage = bottomCharPosition - bottomCharPosition
        
        let additionalDelta = previousBottomDelta * (1 - animationProgress)
        
        bottomDelta = bottomCharOffsetPercentage * charHeight * directionAdjustment + additionalDelta
        
        bottomCharIndex = startIndex + Int(bottomCharPosition * directionAdjustment)
        
        self.charHeight = charHeight
        self.currentWidth = sourceWidth +  (targetWidth - sourceWidth) * animationProgress
    }
    
    func drawColumn() {
        if drawText(characterList: characterList, index: bottomCharIndex, verticalOffset: bottomDelta) {
            if bottomCharIndex >= 0 {
                currentChar = characterList[bottomCharIndex]
            }else if bottomCharIndex == unknown_end_index {
                currentChar = targetChar
            }
            currentBottomDelta = bottomDelta
        }
    }
    
    func drawText(characterList: [Character], index: Int, verticalOffset: CGFloat) -> Bool {
        if index >= 0 && index < characterList.count {
            
            return true
        }else if startIndex == unknown_start_index && index == unknown_start_index {
            
            return true
        }else if endIndex == unknown_end_index && index == unknown_end_index {
            
            return true
        }
        return false
    }
    
    
}
