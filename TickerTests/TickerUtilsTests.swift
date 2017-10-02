//
//  TickerUtilsTests.swift
//  TickerTests
//
//  Created by olddonkey on 2017/9/30.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import XCTest
@testable import Ticker

class TickerUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDefaultListForUSCurrency() {
        let utils = TickerUtils()
        utils.getDefaultListForUSCurrency()
    }
    
}
