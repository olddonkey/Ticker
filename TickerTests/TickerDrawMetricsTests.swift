//
//  TickerDrawMetricsTests.swift
//  TickerTests
//
//  Created by olddonkey on 2017/9/29.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import XCTest
@testable import Ticker

class TickerDrawMetricsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetCharWidth() {
        let metrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: 17))
        XCTAssert(Int(metrics.getCharWidth(character: "s")) == 8)
    }
    
    func testGetCharHeight() {
        let metrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: 17))
        XCTAssert(Int(metrics.getCharHeight()) == 20)
    }
    
    func testGetCharBaseline() {
        let metrics = TickerDrawMetrics(font: UIFont.systemFont(ofSize: 17))
        XCTAssert(Int(metrics.getCharBaseline()) == -4)
    }
    
}
