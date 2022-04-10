//
//  SearchViewModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchViewModel {
    var searchUpdated: () -> Void = {}

    var books = [BookModel]() {
        didSet {
            searchUpdated()
        }
    }
    let searchService = SearchService()

    func searchBooks(keyword: String) {
        self.searchService.searchBooks(keyword: keyword) { [weak self] books in
            guard let self = self else { return }
            self.books.append(contentsOf: books)
        }
    }

}
