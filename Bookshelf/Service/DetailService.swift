//
//  DetailService.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class DetailService {

    private let detailRepository = DetailRepository()

    func detailBookInfo(isbn13: String, completionHandler: @escaping (DetailModel) -> Void) {
        self.detailRepository.detailBookInfo(url: "https://api.itbook.store/1.0/books/\(isbn13)", completionHandler: { detailModel in

            completionHandler(detailModel)
        })
    }

    func fetchNote(isbn13: String, completionHandler: @escaping (String) -> Void) {
        self.detailRepository.fetchNote(isbn13: isbn13) { noteString in
            completionHandler(noteString)
        }
    }

    func saveNote(isbn13: String, note: String, completionHandler: @escaping (Bool) -> Void) {
        self.detailRepository.saveNote(isbn13: isbn13, note: note) { success in
            completionHandler(success)
        }
    }

    func deleteNote(isbn13: String, completionHandler: @escaping (Bool) -> Void) {
        self.detailRepository.deleteNote(isbn13: isbn13) { success in
            completionHandler(success)
        }
    }
}
