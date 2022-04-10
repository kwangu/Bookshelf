//
//  SearchRepository.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation

class SearchRepository {

    func searchBooks(url: String, completionHandler: @escaping (SearchModel) -> Void) {
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

            completionHandler(output)
        }.resume()
    }

}
