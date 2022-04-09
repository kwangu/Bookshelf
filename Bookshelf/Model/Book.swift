//
//  Book.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation

struct Books: Codable {
    var error: String
    var total: String
    var page: String
    var books: [Book]

    init(error: String, total: String, page: String, books: [Book]) {
        self.error = error
        self.total = total
        self.page = page
        self.books = books
    }
}

struct Book: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String

    init(title: String, subtitle: String, isbn13: String,
         price: String, image: String, url: String) {
        self.title = title
        self.subtitle = subtitle
        self.isbn13 = isbn13
        self.price = price
        self.image = image
        self.url = url
    }
}

// "error": "0",
// "total": "71",
// "page": "1",
// "books": [
//    {
//        "title": "Practical MongoDB",
//        "subtitle": "Architecting, Developing, and Administering MongoDB",
//        "isbn13": "9781484206485",
//        "price": "$41.57",
//        "image": "https://itbook.store/img/books/9781484206485.png",
//        "url": "https://itbook.store/books/9781484206485"
//    },
