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
    
    static let unknown_start_index = -1
    static let unknown_end_index = -2
    
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
        
        
    }
    
    func setCharacterIndice() {
        
    }
    
    
}
