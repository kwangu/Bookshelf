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
    private let emptyView = UILabel()

    private let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height +
                 (navigationController?.navigationBar.frame.height ?? 0.0)

        self.title = "Search"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        self.view.backgroundColor = .white

        searchBar.backgroundColor = .white
        searchBar.textColor = .black
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.placeholder = "search books"

        view.addSubview(searchBar)

        let searchButton = UIButton()
        searchButton.setTitle("search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchBooks), for: .touchUpInside)

        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: "BooksTableViewCell")
        view.addSubview(tableView)

        emptyView.text = "Not Result Founds"
        emptyView.textAlignment = .center
        view.addSubview(emptyView)

        searchBar.anchor(top: view.topAnchor, right: searchButton.leadingAnchor, bottom: nil, left: view.leadingAnchor, padding: .init(top: navBarHeight + 16, left: 16, bottom: 0, right: 6), size: .init(width: 0, height: 50))

        searchButton.anchor(top: searchBar.topAnchor, right: view.trailingAnchor, bottom: nil, left: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 70, height: 50))

        tableView.anchor(top: searchBar.bottomAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor)

        emptyView.anchor(top: searchBar.bottomAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        emptyView.isHidden = true
    }

    @objc private func searchBooks() {
        self.searchViewModel.searchUpdated = { count in
            DispatchQueue.main.async {

                if count == -1 {
                    self.tableView.reloadData()
                    return
                }
                if count == 0 {
                    self.tableView.reloadData()
                    self.emptyView.isHidden = false
                    return
                }

                if !self.emptyView.isHidden {
                    self.emptyView.isHidden = true
                }

                var indexPaths = [IndexPath]()
                for i in 1...count {
                    indexPaths.append(IndexPath(row: self.searchViewModel.books.count - i, section: 0))
                }

                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .automatic)
                self.tableView.endUpdates()
            }
        }
        self.searchViewModel.searchBooks(keyword: searchBar.text ?? "")
    }

    private func showDetailView(book: BookModel) {
        let detailView = DetailViewController()
        detailView.book = book
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

 extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.searchViewModel.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as? BooksTableViewCell else { return UITableViewCell()}
        let book = self.searchViewModel.books[indexPath.row]

        cell.title.text = book.title
        cell.url = book.image

        ImageLoader.shared.loadImage(urlString: book.image) { image in
            DispatchQueue.main.async {
                if cell.url == book.image {
                    cell.img.image = image
                }
            }
        }

        return cell
    }

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if indexPath.row == self.searchViewModel.books.count - 10 {
             self.searchBooks()
         }
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.showDetailView(book: self.searchViewModel.books[indexPath.row])
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 80
     }
 }
