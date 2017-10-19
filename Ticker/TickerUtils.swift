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
    
    public static func getDefaultListForUSCurrency() -> [Character]{
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
        
        charList.insert(TickerUtils.EMPTY_CHAR, at: Int(indexOf0-start))
        charList.rearrange(from: Int(indexOfSlash-start), to: Int(indexOfPeriod-start))
        
        for i in (indexOf0 + 1)..<(end+1) {
            guard let scalar = UnicodeScalar(i-1) else {
                print("Can't init unicode scalar")
                return [Character]()
            }
            charList.insert(Character(scalar), at: Int(i-start))
        }
        
        return charList
    }
    
    public static func getDefaultNumberList() -> [Character] {
        var charList: [Character] = [Character]()
        charList.append(TickerUtils.EMPTY_CHAR)
        charList.append(Character("."))
        for i in 0..<10 {
            guard let scalar = UnicodeScalar(i+48) else {
                print("Can't init unicode scalar")
                return [Character]()
            }
            charList.insert(Character(scalar), at: Int(i+2))
        }
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

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}

func synchronized(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
