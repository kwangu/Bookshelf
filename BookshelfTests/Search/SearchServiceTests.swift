//
//  SearchServiceTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/11.
//

import XCTest
@testable import Bookshelf

class SearchServiceTests: XCTestCase {

    let searchService = SearchService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBooks() throws {
        let promise = expectation(description: "Completion handler invoked")

        searchService.searchBooks(isFirst: true, keyword: "swift", completionHandler: { bookModel in
            XCTAssertNotNil(bookModel)
            promise.fulfill()
        })

        wait(for: [promise], timeout: 3)
    }

}
