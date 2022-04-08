//
//  Book.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation

struct Book: Codable {
    var title: String
    var subTitle: String
    var isbn13: String
    var price: String
    var imagePath: String
    var url: String
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
