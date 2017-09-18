//
//  LavenshteinDistanceTests.swift
//  TickerTests
//
//  Created by olddonkey on 2017/9/18.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import XCTest
@testable import Ticker

class LavenshteinDistanceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_insert_case1() {
        runTest(source: "1111", target: "11211", actionInString: "00100")
    }
    
    func test_insert_case2() {
        runTest(source: "123", target: "0213", actionInString: "0010")
    }
    
    func test_deletion() {
        runTest(source: "11211", target: "1111", actionInString: "00200")
    }
    
    func test_equal() {
        runTest(source: "1234", target: "1234", actionInString: "0000")
    }
    
    func test_noSame_equalLength() {
        runTest(source: "1234", target: "5678", actionInString: "0000")
    }
    
    func test_shift() {
        runTest(source: "1234", target: "2345", actionInString: "0000")
    }
    
    func test_mix1() {
        runTest(source: "15233", target: "9151", actionInString: "100220")
    }
    
    func test_mix2() {
        runTest(source: "12345", target: "230", actionInString: "20020")
    }
    
    func testCurrency() {
        runTest(source: "$123.99", target: "$1223.98", actionInString: "00010000")
    }
    
    func testTime1() {
        runTest(source: "11:25 AM", target: "11:55 AM", actionInString: "00000000")
    }
    
    func testTime2() {
        runTest(source: "10:25 AM", target: "9:05 PM", actionInString: "20000000")
    }
    
    func runTest(source: String, target: String, actionInString: String) {
        let result = LevenshteiDistance.computeColumnAction(source: source, target: target)
        let correctResult = convertStringToActions(source: actionInString)
        assert(result == correctResult, "Shold be the same")
        
    }
    
    func convertStringToActions(source: String) -> [LevenshteiDistance.action] {
        let source = Array(source.characters)
        var result = [LevenshteiDistance.action]()
        for char in source {
            if char == "0" {
                result.append(.update)
            }else if char == "1" {
                result.append(.insertion)
            }else if char == "2" {
                result.append(.deletion)
            }else {
                assertionFailure("The String is not valid")
            }
        }
        return result
    }
    
}
