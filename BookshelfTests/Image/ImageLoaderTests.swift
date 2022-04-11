//
//  ImageLoaderTests.swift
//  BookshelfTests
//
//  Created by 강관구 on 2022/04/12.
//

import XCTest

class ImageLoaderTests: XCTestCase {
    let urlString = "https://itbook.store/img/books/9780321769626.png"
    let downloadManager = DownloadManager()

    private let imageCache = NSCache<NSString, UIImage>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadImage() throws {
        let promise = expectation(description: "Completion handler invoked")
        downloadManager.downloadImage(urlString: urlString, completionHandler: {[weak self] image in

            guard let self = self else { return }

            self.imageCache.setObject(image, forKey: self.urlString as NSString)

            let cacheImage = self.imageCache.object(forKey: self.urlString as NSString)
            XCTAssertNotNil(cacheImage)

            promise.fulfill()

        })
        wait(for: [promise], timeout: 3)
    }
}
