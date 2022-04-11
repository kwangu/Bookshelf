//
//  ImageLoader.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/11.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()

    private lazy var imageCache = NSCache<NSString, UIImage>()

    init() {
        imageCache.countLimit = 50
    }

    func loadImage(urlString: String, completionHandler: @escaping (UIImage) -> Void) {

        // cache
        if let image = imageCache.object(forKey: urlString as NSString) {
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

                imageCache.setObject(image, forKey: url.lastPathComponent as NSString)

                completionHandler(image)

                return
            }
        }

        DownloadManager().downloadImage(urlString: urlString) { [weak self] image in
            guard let self = self else { return }

            self.imageCache.setObject(image, forKey: urlString as NSString)

            completionHandler(image)
        }
    }

}
