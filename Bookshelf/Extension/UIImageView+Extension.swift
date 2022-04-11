//
//  UIImageView+Extension.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/11.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImage(urlString: String) {

        // cache
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
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

                self.image = image

                return
            }
        }

        DownloadManager().downloadImage(urlString: urlString) { [weak self] image in
            guard let self = self else { return }

            imageCache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
