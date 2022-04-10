//
//  DetailModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/09.
//

import Foundation

struct DetailModel: Codable {
    var error: String
    var title: String
    var subtitle: String
    var authors: String
    var publisher: String
    var language: String
    var isbn10: String
    var isbn13: String
    var pages: String
    var year: String
    var rating: String
    var desc: String
    var price: String
    var image: String
    var url: String

    init(error: String, title: String, subtitle: String, authors: String, publisher: String, language: String, isbn10: String, isbn13: String, pages: String, year: String, rating: String, desc: String, price: String, image: String, url: String) {
        self.error = error
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.language = language
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.pages = pages
        self.year = year
        self.rating = rating
        self.desc = desc
        self.price = price
        self.image = image
        self.url = url
    }
}

// {
//    "error": "0",
//    "title": "A Swift Kickstart, 2nd Edition",
//    "subtitle": "Introducing the Swift Programming Language",
//    "authors": "Daniel H Steinberg",
//    "publisher": "The Pragmatic Programmers",
//    "language": "English",
//    "isbn10": "0983066981",
//    "isbn13": "9780983066989",
//    "pages": "414",
//    "year": "2017",
//    "rating": "0",
//    "desc": "This is the perfect book for the experienced developer who wants to get serious about learning the Swift programming language. If you know at least one modern programming language, this book will teach you how to think and program in Swift. Swift's design is inspired by elements from object-oriented...",
//    "price": "$29.99",
//    "image": "https://itbook.store/img/books/9780983066989.png",
//    "url": "https://itbook.store/books/9780983066989"
// }
