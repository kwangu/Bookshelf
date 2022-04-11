//
//  DetailServiceTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/11.
//

import XCTest
@testable import Bookshelf

class DetailServiceTests: XCTestCase {

    let isbn13 = "9781492044550"
    let detailService = DetailService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailBookInfo() throws {
        let promise = expectation(description: "Completion handler invoked")

        detailService.detailBookInfo(isbn13: isbn13, completionHandler: { detailModel in
            XCTAssertNotNil(detailModel)

            promise.fulfill()
        })

        wait(for: [promise], timeout: 3)
    }

}
