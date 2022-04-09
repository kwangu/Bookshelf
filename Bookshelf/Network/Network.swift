//
//  Network.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation

class Network {
    var session: URLSession?

    init() {
        self.session = URLSession(configuration: .default)
    }

    func getSearchBooks(url: String, completionHandler: @escaping (Bool, Books) -> Void) {
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session?.dataTask(with: request) { data, response, error in
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

            guard let output = try? JSONDecoder().decode(Books.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            completionHandler(true, output)
        }.resume()

        session?.finishTasksAndInvalidate()
    }

    func getDetailBooks(url: String, completionHandler: @escaping (Bool, DetailBook) -> Void) {
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session?.dataTask(with: request) { data, response, error in
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

            guard let output = try? JSONDecoder().decode(DetailBook.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            completionHandler(true, output)
        }.resume()

        session?.finishTasksAndInvalidate()
    }
}
