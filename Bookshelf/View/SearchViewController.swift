//
//  SearchViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    private let searchBar = UITextField()
    private let tableView = UITableView()

    private var books = [Book]()
    let imageLoader = ImageLoader()
    var currentPage = 0
    var totalPage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
                 (navigationController?.navigationBar.frame.height ?? 0.0)

        self.title = "Search"
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = .white

        searchBar.backgroundColor = .white
        searchBar.borderStyle = .roundedRect
        searchBar.textColor = .black
        searchBar.placeholder = "search books"

        view.addSubview(searchBar)

        let searchButton = UIButton()
        searchButton.setTitle("search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(firstSearchBooks), for: .touchUpInside)

        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: "BooksTableViewCell")
        view.addSubview(tableView)

        searchBar.anchor(top: view.topAnchor, right: searchButton.leadingAnchor, bottom: nil, left: view.leadingAnchor, padding: .init(top: navBarHeight + 16, left: 16, bottom: 0, right: 6), size: .init(width: 0, height: 50))

        searchButton.anchor(top: searchBar.topAnchor, right: view.trailingAnchor, bottom: nil, left: searchBar.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 70, height: 50))

        tableView.anchor(top: searchBar.bottomAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }

    @objc private func firstSearchBooks() {
        self.books.removeAll()
        self.currentPage = 0
        self.totalPage = nil

        searchBooks()
    }

    @objc private func searchBooks() {

        self.currentPage += 1

        if totalPage != nil && self.currentPage > totalPage ?? 0 {
            return
        }

        Network().getSearchBooks(url: "https://api.itbook.store/1.0/search/\(searchBar.text ?? "")/\(String(currentPage))", completionHandler: { success, books in
            if success {

                if self.totalPage == nil {
                    let total = Int(books.total) ?? 0
                    self.totalPage = total % 10 == 0 ? total / 10 : (total / 10)+1
                }

                books.books.forEach { book in
                    self.books.append(book)
                }
            } else {
                print("netwrok error")
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        })
    }

    @objc private func showDetailView() {
        let detailView = DetailBookViewController()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

 extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as? BooksTableViewCell else { return UITableViewCell()}
        let book = self.books[indexPath.row]
        cell.title.text = book.title
        imageLoader.getImage(urlString: book.image, completionHandler: { image in
            DispatchQueue.main.async {
                cell.img.image = image
            }
        })

        if indexPath.row == books.count - 10 {
            self.searchBooks()
        }

        return cell
    }
 }
