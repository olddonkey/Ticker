//
//  TickerDrawMetrics.swift
//  Ticker
//
//  Created by olddonkey on 2017/9/18.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class TickerDrawMetrics {
    
    var font: UIFont
    var charHeight: CGFloat
    var charBaseline: CGFloat
    var charWidthDictionary: [Character: CGFloat] = [Character: CGFloat]()
    required init(font: UIFont) {
        self.font = font
        charHeight = font.lineHeight
        charBaseline = font.descender
    }
    
    func getCharWidth(character: Character) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        
        if character == TickerUtils.EMPTY_CHAR {
            return 0
        }
        
        if let charWidth = charWidthDictionary[character] {
            return charWidth
        }else {
            let charString = String(character)
            let sizeofText = charString.size(withAttributes: fontAttributes)
            charWidthDictionary[character] = sizeofText.width
            return sizeofText.width
        }
    }
    
    func getCharHeight() -> CGFloat {
        return charHeight
    }
    
    func getCharBaseline() -> CGFloat {
        return charBaseline
    }
}

