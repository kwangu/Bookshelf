//
//  DetailViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class DetailBookViewController: UIViewController {
    private let imageLoader = ImageLoader()

    var book: Book?
    var detailBook: DetailBook?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        self.title = "Detail"
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = .white

        Network().getDetailBooks(url: "https://api.itbook.store/1.0/books/\(book?.isbn13 ?? "")",
                                 completionHandler: { success, book in
            if success {
                self.detailBook = book
                print(book)
                DispatchQueue.main.async {
                    self.setupDetailUI()
                }

            } else {
                print("error")
            }
        })
    }

    func setupDetailUI() {

        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)

        scrollView.anchor(top: view.topAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor)

        let detailImage = UIImageView()
        imageLoader.getImage(urlString: book?.image ?? "", completionHandler: { image in
            detailImage.image = image
        })
        scrollView.addSubview(detailImage)

        detailImage.anchor(top: scrollView.topAnchor, right: nil, bottom: nil, left: nil, centerX: scrollView.centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))

        let title = UILabel()
        scrollView.addSubview(title)
        title.numberOfLines = 0
        title.text = "title : \(detailBook?.title ?? "")"

        let subtitle = UILabel()
        scrollView.addSubview(subtitle)
        subtitle.numberOfLines = 0
        subtitle.text = "subtitle : \(detailBook?.subtitle ?? "")"

        let authors = UILabel()
        scrollView.addSubview(authors)
        authors.numberOfLines = 0
        authors.text = "authors : \(detailBook?.authors ?? "")"

        let publisher = UILabel()
        scrollView.addSubview(publisher)
        publisher.numberOfLines = 0
        publisher.text = "publisher : \(detailBook?.publisher ?? "")"

        let language = UILabel()
        scrollView.addSubview(language)
        language.numberOfLines = 0
        language.text = "language : \(detailBook?.language ?? "")"

        let isbn10 = UILabel()
        scrollView.addSubview(isbn10)
        isbn10.numberOfLines = 0
        isbn10.text = "isbn10 : \(detailBook?.isbn10 ?? "")"

        let isbn13 = UILabel()
        scrollView.addSubview(isbn13)
        isbn13.numberOfLines = 0
        isbn13.text = "isbn13 : \(detailBook?.isbn13 ?? "")"

        let pages = UILabel()
        scrollView.addSubview(pages)
        pages.numberOfLines = 0
        pages.text = "pages : \(detailBook?.pages ?? "")"

        let year = UILabel()
        scrollView.addSubview(year)
        year.numberOfLines = 0
        year.text = "year : \(detailBook?.year ?? "")"

        let rating = UILabel()
        scrollView.addSubview(rating)
        rating.numberOfLines = 0
        rating.text = "rating : \(detailBook?.rating ?? "")"

        let desc = UILabel()
        scrollView.addSubview(desc)
        desc.numberOfLines = 0
        desc.text = "desc : \(detailBook?.desc ?? "")"

        let url = UILabel()
        scrollView.addSubview(url)
        url.numberOfLines = 0
        url.text = detailBook?.url

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

        url.anchor(top: desc.bottomAnchor, right: view.trailingAnchor, bottom: scrollView.bottomAnchor, left: view.leadingAnchor,
                     padding: .init(top: 15, left: 16, bottom: 0, right: 16))

    }
}
