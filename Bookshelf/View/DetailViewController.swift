//
//  DetailViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    private let noteView = UITextView()

    var book: BookModel?

    private var detailViewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewModel = DetailViewModel()

        self.title = book?.title ?? ""
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = .white

        self.detailViewModel?.bookInfoUpdated = {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
        self.detailViewModel?.detailBookInfo(isbn13: book?.isbn13 ?? "")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.detailViewModel = nil
    }

    func setupUI() {

        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)

        scrollView.anchor(top: view.topAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor)

        let detailImage = UIImageView()
        ImageLoader.shared.loadImage(urlString: book?.image ?? "") { image in
            DispatchQueue.main.async {
                detailImage.image = image
            }
        }
        scrollView.addSubview(detailImage)

        detailImage.anchor(top: scrollView.topAnchor, right: nil, bottom: nil, left: nil, centerX: scrollView.centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

        let title = UILabel()
        scrollView.addSubview(title)
        title.numberOfLines = 0
        title.textColor = .black
        title.text = "title : \(self.detailViewModel?.detailBook?.title ?? "")"

        let subtitle = UILabel()
        scrollView.addSubview(subtitle)
        subtitle.numberOfLines = 0
        subtitle.textColor = .black
        subtitle.text = "subtitle : \(self.detailViewModel?.detailBook?.subtitle ?? "")"

        let authors = UILabel()
        scrollView.addSubview(authors)
        authors.numberOfLines = 0
        authors.textColor = .black
        authors.text = "authors : \(self.detailViewModel?.detailBook?.authors ?? "")"

        let publisher = UILabel()
        scrollView.addSubview(publisher)
        publisher.numberOfLines = 0
        publisher.textColor = .black
        publisher.text = "publisher : \(self.detailViewModel?.detailBook?.publisher ?? "")"

        let language = UILabel()
        scrollView.addSubview(language)
        language.numberOfLines = 0
        language.textColor = .black
        language.text = "language : \(self.detailViewModel?.detailBook?.language ?? "")"

        let isbn10 = UILabel()
        scrollView.addSubview(isbn10)
        isbn10.numberOfLines = 0
        isbn10.textColor = .black
        isbn10.text = "isbn10 : \(self.detailViewModel?.detailBook?.isbn10 ?? "")"

        let isbn13 = UILabel()
        scrollView.addSubview(isbn13)
        isbn13.numberOfLines = 0
        isbn13.textColor = .black
        isbn13.text = "isbn13 : \(self.detailViewModel?.detailBook?.isbn13 ?? "")"

        let pages = UILabel()
        scrollView.addSubview(pages)
        pages.numberOfLines = 0
        pages.textColor = .black
        pages.text = "pages : \(self.detailViewModel?.detailBook?.pages ?? "")"

        let year = UILabel()
        scrollView.addSubview(year)
        year.numberOfLines = 0
        year.textColor = .black
        year.text = "year : \(self.detailViewModel?.detailBook?.year ?? "")"

        let rating = UILabel()
        scrollView.addSubview(rating)
        rating.numberOfLines = 0
        rating.textColor = .black
        rating.text = "rating : \(self.detailViewModel?.detailBook?.rating ?? "")"

        let desc = UILabel()
        scrollView.addSubview(desc)
        desc.numberOfLines = 0
        desc.textColor = .black
        desc.text = "desc : \(self.detailViewModel?.detailBook?.desc ?? "")"

        let price = UILabel()
        scrollView.addSubview(price)
        price.numberOfLines = 0
        price.textColor = .black
        price.text = "price : \(self.detailViewModel?.detailBook?.price ?? "")"

        let url = UITextView()
        scrollView.addSubview(url)
        url.text = self.detailViewModel?.detailBook?.url
        url.backgroundColor = .white
        url.isEditable = false
        url.isScrollEnabled = false
        url.dataDetectorTypes = .link
        url.isUserInteractionEnabled = true

        scrollView.addSubview(noteView)
        noteView.backgroundColor = .white
        noteView.textColor = .black
        noteView.layer.borderWidth = 1.0
        noteView.layer.borderColor = UIColor.systemGray.cgColor

        let saveButton = UIButton()
        saveButton.setTitle("save note", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.numberOfLines = 0
        saveButton.layer.borderColor = UIColor.gray.cgColor
        saveButton.layer.borderWidth = 1.0
        saveButton.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        scrollView.addSubview(saveButton)

        let deleteButton = UIButton()
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.titleLabel?.numberOfLines = 0
        deleteButton.layer.borderColor = UIColor.gray.cgColor
        deleteButton.layer.borderWidth = 1.0
        deleteButton.setTitle("delete note", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        scrollView.addSubview(deleteButton)

        title.anchor(top: detailImage.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 0, left: 16, bottom: 0, right: 16))

        subtitle.anchor(top: title.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        authors.anchor(top: subtitle.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        publisher.anchor(top: authors.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        language.anchor(top: publisher.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        isbn10.anchor(top: language.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        isbn13.anchor(top: isbn10.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        pages.anchor(top: isbn13.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        year.anchor(top: pages.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        rating.anchor(top: year.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        desc.anchor(top: rating.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        price.anchor(top: desc.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        url.anchor(top: price.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

        noteView.anchor(top: url.bottomAnchor, right: saveButton.leadingAnchor, bottom: nil, left: view.leadingAnchor,
                    padding: .init(top: 15, left: 16, bottom: 0, right: 10), size: .init(width: 0, height: 100))

        saveButton.anchor(top: url.bottomAnchor, right: view.trailingAnchor, bottom: nil, left: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 16), size: .init(width: 60, height: 100))

        deleteButton.anchor(top: noteView.bottomAnchor, right: view.trailingAnchor, bottom: scrollView.bottomAnchor, left: view.leadingAnchor, padding: .init(top: 15, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))

        self.fetchNote()
    }

    @objc private func saveNote() {
        self.detailViewModel?.saveNote(isbn13: self.detailViewModel?.detailBook?.isbn13 ?? "", note: noteView.text ?? "")
    }

    @objc private func deleteNote() {
        self.fetchNote()

        self.detailViewModel?.deleteNote(isbn13: self.detailViewModel?.detailBook?.isbn13 ?? "")
    }

    private func fetchNote() {
        self.detailViewModel?.noteUpdated = {
            DispatchQueue.main.async {
                self.noteView.text = self.detailViewModel?.note
            }
        }

        self.detailViewModel?.fetchNote(isbn13: self.detailViewModel?.detailBook?.isbn13 ?? "")
    }
}
