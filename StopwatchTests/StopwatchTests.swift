//
//  StopwatchTests.swift
//  StopwatchTests
//
//  Created by Sipan on 2020-05-18.
//  Copyright © 2020 Sipan. All rights reserved.
//

import XCTest
@testable import Stopwatch

class StopwatchTests: XCTestCase {

    var sut:  LapManager!

    override func setUp() {
        super.setUp()
        sut = LapManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLapIncrement() {
        sut.startTimer()
        sut.addLap()
        XCTAssert(sut.laps.count == 1)
    }
}
