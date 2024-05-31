//
//  LibraryTests.swift
//  LittleThingsTests (iOS)
//
//  Created by Patrick on 4/14/23.
//

import XCTest
@testable import LittleThings

final class LibraryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func checkDaysBetweenStartDateInPast() throws {
        let days = daysBetween(start: convertStringToDate(dateString: "2022-03-30"), end: convertStringToDate(dateString: "2023-03-30"))
        XCTAssert(days == 365)
    }
    
    func checkDaysBetweenEndDateInPast() throws {
        let days = daysBetween(start: convertStringToDate(dateString: "2023-03-30"), end: convertStringToDate(dateString: "2022-03-30"))
        XCTAssert(days == 365)
    }
    
    func checkDaysUntilDateInPast() throws {
        let dates = [convertStringToDate(dateString: "2024-03-30"), convertStringToDate(dateString: "2025-04-30")]
        let days = closestDaysUntilNextEvent(dates: dates)
        XCTAssert(days == 365)
    }
}
