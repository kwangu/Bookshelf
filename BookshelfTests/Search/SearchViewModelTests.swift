//
//  SearchViewModelTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/11.
//

import XCTest
@testable import Bookshelf

class SearchViewModelTests: XCTestCase {

    let keyword = "swift"
    let searchViewModel = SearchViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchBooks() throws {
        let promise = expectation(description: "Completion handler invoked")

        XCTAssertEqual(searchViewModel.books.count, 0)

        searchViewModel.searchService.searchBooks(isFirst: true, keyword: keyword, completionHandler: { books in
            XCTAssertNotNil(books)
            self.searchViewModel.books.append(contentsOf: books)

            XCTAssertEqual(self.searchViewModel.books.count, 10)
            promise.fulfill()
        })

        wait(for: [promise], timeout: 3)
    }

}
