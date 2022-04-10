//
//  ImageLoader.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/09.
//

import Foundation
import UIKit

class ImageLoader {
    private let imageCache = NSCache<NSString, UIImage>()

    init() {
        self.imageCache.countLimit = 100
    }

    func getImage(urlString: String, completionHandler: @escaping (UIImage) -> Void) {

        // cache
        if let image = self.imageCache.object(forKey: urlString as NSString) {
            completionHandler(image)
            return
        }

        // file
        if let url = URL(string: urlString) {
            guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }

            let fileManager = FileManager.default
            var filePath = URL(fileURLWithPath: path)
            filePath.appendPathComponent(url.lastPathComponent)

            if fileManager.fileExists(atPath: filePath.path) {
                guard let imageData = try? Data(contentsOf: filePath) else { return }
                guard let image = UIImage(data: imageData) else { return }

                self.imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
                completionHandler(image)
                return
            }
        }

        let session: URLSession = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
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
                    self.imageCache.setObject(image, forKey: urlString as NSString)

                    completionHandler(image)

                } catch let error {
                    print(error)
                }
            }).resume()

            session.finishTasksAndInvalidate()
        }
    }

}
