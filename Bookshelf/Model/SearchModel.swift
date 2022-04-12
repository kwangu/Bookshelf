//
//  SearchModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

struct SearchModel: Codable {
    var error: String
    var total: String
    var page: String?
    var books: [BookModel]

    init(error: String, total: String, page: String? = nil, books: [BookModel]) {
        self.error = error
        self.total = total
        self.page = page
        self.books = books
    }
}
