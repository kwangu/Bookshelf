//
//  SearchViewModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchViewModel {
    private var currentKeyword: String = ""
    var searchUpdated: () -> Void = {}

    var books = [BookModel]() {
        didSet {
            searchUpdated()
        }
    }
    private let searchService = SearchService()

    func searchBooks(keyword: String) {
        if currentKeyword != keyword {
            currentKeyword = keyword

            self.books.removeAll()
        }

        self.searchService.searchBooks(keyword: keyword) { [weak self] books in
            guard let self = self else { return }
            self.books.append(contentsOf: books)
        }
    }

}
