//
//  Book.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation

struct BookModel: Codable {
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
