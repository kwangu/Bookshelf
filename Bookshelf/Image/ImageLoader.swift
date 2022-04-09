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

    func getImage(urlString: String, completionHandler: @escaping (UIImage) -> Void) {
        let session: URLSession = URLSession(configuration: .default)
        if let image = imageCache.object(forKey: urlString as NSString) {
            completionHandler(image)
        } else {
            if let url = URL(string: urlString) {
                session.downloadTask(with: url, completionHandler: { (_, _, _) -> Void in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            self.imageCache.setObject(image, forKey: urlString as NSString)
                            completionHandler(image)
                        }
                    }
                }).resume()

                session.finishTasksAndInvalidate()
            }
        }
    }

}
