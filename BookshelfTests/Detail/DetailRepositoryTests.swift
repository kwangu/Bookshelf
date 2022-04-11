//
//  DetailRepositoryTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/11.
//

import XCTest
@testable import Bookshelf

class DetailRepositoryTests: XCTestCase {

    let url = "https://api.itbook.store/1.0/books/9781492044550"
    let detailRepository = DetailRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailBookInfo() throws {
        let promise = expectation(description: "Completion handler invoked")
        detailRepository.detailBookInfo(url: url, completionHandler: { detailModel in
            XCTAssertNotNil(detailModel)

            promise.fulfill()
        })

        wait(for: [promise], timeout: 3)
    }

}
