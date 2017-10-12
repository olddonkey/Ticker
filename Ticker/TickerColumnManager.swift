//
//  TickerColumnManager.swift
//  Ticker
//
//  Created by olddonkey on 2017/10/8.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerColumnManager: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var tickerColumns: [TickerColumn] = [TickerColumn]()
    var metrics: TickerDrawMetrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: 17))
    
    var characterList: [Character] = [Character]()
    
    var characterIndicesMap: [Character: Int] = [Character: Int]()
    
    init(metrics: TickerDrawMetrics) {
        self.metrics = metrics
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCharacterList(characterList: [Character]) {
        self.characterList = characterList
        self.characterIndicesMap = [Character: Int]()
        
        for i in 0..<characterList.count {
            characterIndicesMap[characterList[i]] = i
        }
    }
    
    func setText(text: [Character]) {
        if characterList.count == 0 {
            assertionFailure("Need to set characterList first")
        }
        
        for i in 0..<tickerColumns.count {
            let tickerColumn = tickerColumns[i]
            if tickerColumn.getCurrentWidth() > 0 {
                //Continue
            }else {
                tickerColumns.remove(at: i)
            }
        }
        
        let actions = LevenshteiDistance.computeColumnAction(source: String(getCurrentText()), target: String(text))
        var columnIndex = 0
        var textIndex = 0
        for i in 0..<actions.count {
            if actions[i] == LevenshteiDistance.action.insertion {
                tickerColumns.insert(TickerColumn(characterList: characterList, characterIndicesMap: characterIndicesMap, metrics: metrics), at: columnIndex)
            }else if actions[i] == LevenshteiDistance.action.update {
                tickerColumns[columnIndex].setTargetChar(targetChar: text[textIndex])
                columnIndex += 1
                textIndex += 1
            }else if actions[i] == LevenshteiDistance.action.deletion {
                tickerColumns[columnIndex].setTargetChar(targetChar: TickerUtils.EMPTY_CHAR)
                columnIndex += 1
            }else {
                print("Unknown action: \(actions[i])")
            }
        }
    }
    
    func onAnimationEnd() {
        for i in 0..<tickerColumns.count {
            let column = tickerColumns[i]
            column.onAnimationEnd()
        }
    }
    
    func setAnimationProgress(animationProgress: CGFloat) {
        for i in 0..<tickerColumns.count {
            let column = tickerColumns[i]
            column.setAnimationProgress(animationProgress: animationProgress)
        }
    }
    
    func getMinimumRequiredWidth() -> CGFloat {
        var width: CGFloat = 0
        for i in 0..<tickerColumns.count {
            width += tickerColumns[i].getMinimunRequiredWidth()
        }
        return width
    }
    
    func getCurrentWidth() -> CGFloat {
        var width: CGFloat = 0
        for i in 0..<tickerColumns.count {
            width += tickerColumns[i].getCurrentWidth()
        }
        return width
    }
    
    func getCurrentText() -> [Character] {
        let size = tickerColumns.count
        var currentText = [Character]()
        for i in 0..<size {
            currentText.insert(tickerColumns[i].getCurrentChar(), at: i)
        }
        return currentText
    }
}
