//
//  TickerUtils.swift
//  Ticker
//
//  Created by olddonkey on 2017/9/30.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import Foundation

class TickerUtils {
    public static let EMPTY_CHAR: Character = Character(UnicodeScalar(0))
    
    func getDefaultListForUSCurrency() -> [Character]{
        let indexOf0 = Character("0").asciiValue
        let indexOfPeriod = Character(".").asciiValue
        let indexOfSlash = Character("/").asciiValue
        
        let start: UInt32 = 33
        let end: UInt32 = 256
        
        var charList: [Character] = [Character]()
        for i in start..<indexOf0 {
            guard let charValue = UnicodeScalar(i) else {
                print("Can't convert \(i) to it is value")
                return [Character]()
            }
            charList.insert(Character(charValue), at: (Int)(i - start))
        }
        
        charList.insert(TickerUtils.EMPTY_CHAR, at: Int(indexOf0))
        charList.insert(TickerUtils.EMPTY_CHAR, at: Int(indexOf0))
        charList.insert(TickerUtils.EMPTY_CHAR, at: Int(indexOf0))
        return charList
    }
}

extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
extension Character {
    var asciiValue: UInt32 {
        guard let value = String(self).unicodeScalars.first?.value else{
            return 0
        }
        return value
    }
}
