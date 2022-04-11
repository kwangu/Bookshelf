//
//  SearchRepositoryTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/11.
//

import XCTest
@testable import Bookshelf

class SearchRepositoryTests: XCTestCase {

    let urlString = "https://api.itbook.store/1.0/search/swift/1"
    let searchRepository = SearchRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBooks() throws {
        let promise = expectation(description: "Completion handler invoked")

        searchRepository.searchBooks(url: urlString, completionHandler: { searchModel in

            XCTAssertNotNil(searchModel)
            promise.fulfill()

        })

        wait(for: [promise], timeout: 3)
    }

}
