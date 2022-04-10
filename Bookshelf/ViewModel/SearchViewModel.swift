//
//  SearchViewModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchViewModel {
    private var currentKeyword: String = ""
    var searchUpdated: (Int) -> Void = { _ in }
    private var updatedCount: Int = 0

    var books = [BookModel]() {
        didSet {
            searchUpdated(updatedCount)
        }
    }
    private let searchService = SearchService()

    func searchBooks(keyword: String) {
        if currentKeyword != keyword {
            currentKeyword = keyword
            updatedCount = 0
            self.books.removeAll()
        }

        self.searchService.searchBooks(isFirst: updatedCount == 0, keyword: keyword) { [weak self] books in
            guard let self = self else { return }
            self.updatedCount = books.count
            self.books.append(contentsOf: books)
        }
    }

}
