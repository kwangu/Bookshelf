//
//  DeatilViewModel.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class DetailViewModel {
    var bookInfoUpdated: () -> Void = {}
    var noteUpdated: () -> Void = {}

    var detailBook: DetailModel? {
        didSet {
            bookInfoUpdated()
        }
    }

    var note: String = "" {
        didSet {
            noteUpdated()
        }
    }

    private let detailService = DetailService()

    func detailBookInfo(isbn13: String) {
        self.detailService.detailBookInfo(isbn13: isbn13) {[weak self] detailModel in
            guard let self = self else { return }
            self.detailBook = detailModel
        }
    }

    func fetchNote(isbn13: String) {
        self.detailService.fetchNote(isbn13: isbn13) { [weak self] noteString in
            guard let self = self else { return }
            self.note = noteString
        }
    }

    func saveNote(isbn13: String, note: String) {
        self.detailService.saveNote(isbn13: isbn13, note: note) { success in
            if success {
                print("save success")
            } else {
                print("save fail")
            }
        }
    }

    func deleteNote(isbn13: String) {
        self.detailService.deleteNote(isbn13: isbn13) { success in
            if success {
                self.note = ""
                print("delete success")
            } else {
                print("delete fail")
            }
        }
    }

}
