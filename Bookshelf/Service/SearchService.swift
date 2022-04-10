//
//  SearchService.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchService {
    var currentPage = 0
    var totalPage: Int?
    let searchRepository = SearchRepository()

    func searchBooks(keyword: String, completionHandler: @escaping ([BookModel]) -> Void) {

        self.currentPage += 1

        if totalPage != nil && self.currentPage > totalPage ?? 0 {
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
