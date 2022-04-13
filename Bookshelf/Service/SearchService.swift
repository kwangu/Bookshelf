//
//  SearchService.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchService {

    private let searchRepository = SearchRepository()

    func searchBooks(isFirst: Bool, keyword: String, completionHandler: @escaping ([BookModel]) -> Void) {

        // SearchModel -> [BookModel] 
        searchRepository.searchBooks(isFirst: isFirst, keyword: keyword, completionHandler: { searchModel in
            completionHandler(searchModel.books)
        })
    }

}
