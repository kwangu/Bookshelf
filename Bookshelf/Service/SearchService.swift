//
//  SearchService.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchService {
    private var currentPage = 0
    private var totalPage: Int?
    private let searchRepository = SearchRepository()

    func searchBooks(isFirst: Bool, keyword: String, completionHandler: @escaping ([BookModel]) -> Void) {
        if isFirst {
            currentPage = 0
            totalPage = nil
        }

        self.currentPage += 1

        if self.totalPage != nil && self.currentPage > self.totalPage ?? 0 {
            return
        }

        searchRepository.searchBooks(url: "https://api.itbook.store/1.0/search/\(keyword)/\(String(currentPage))", completionHandler: { searchModel in

            if self.totalPage == nil {
                let total = Int(searchModel.total) ?? 0
                self.totalPage = total % 10 == 0 ? total / 10 : (total / 10)+1
            }

            completionHandler(searchModel.books)
        })
    }

}
