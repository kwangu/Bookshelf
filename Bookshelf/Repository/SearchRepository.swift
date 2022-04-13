//
//  SearchRepository.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchRepository {

    private var currentPage = 0
    private var totalPage: Int?

    func searchBooks(isFirst: Bool, keyword: String, completionHandler: @escaping (SearchModel) -> Void) {

        if isFirst {
            currentPage = 0
            totalPage = nil
        }

        self.currentPage += 1

        let url = "https://api.itbook.store/1.0/search/\(keyword)/\(String(currentPage))"

        if self.totalPage != nil && self.currentPage > self.totalPage ?? 0 {
            return
        }

        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            guard let output = try? JSONDecoder().decode(SearchModel.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            if self.totalPage == nil {
                let total = Int(output.total) ?? 0
                self.totalPage = total % 10 == 0 ? total / 10 : (total / 10)+1
            }

            completionHandler(output)

        }.resume()
    }

}
