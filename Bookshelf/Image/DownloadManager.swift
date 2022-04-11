//
//  DownloadManager.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/11.
//

import Foundation
import UIKit

struct DownloadManager {

    func downloadImage(urlString: String, completionHandler: @escaping (UIImage) -> Void) {
        if let url = URL(string: urlString) {
            let session: URLSession = URLSession(configuration: .default)
            session.downloadTask(with: url, completionHandler: { (location, _, error) -> Void in
                let fileManager = FileManager.default
                let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationURL = documentURL.appendingPathComponent(url.lastPathComponent)
                print(destinationURL)

                try? fileManager.removeItem(at: destinationURL)

                do {
                    guard let location = location else { return }
                    try fileManager.copyItem(at: location, to: destinationURL)
                    guard let imageData = try? Data(contentsOf: destinationURL) else { return }
                    guard let image = UIImage(data: imageData) else { return }

                    completionHandler(image)

                } catch let error {
                    print(error)
                }
            }).resume()

            session.finishTasksAndInvalidate()
        }
    }

}
