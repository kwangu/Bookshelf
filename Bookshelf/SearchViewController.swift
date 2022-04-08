//
//  SearchViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "search view"
        self.view.backgroundColor = .systemRed

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        button.setTitle("detail", for: .normal)
        button.addTarget(self, action: #selector(showDetailView), for: .touchUpInside)

        view.addSubview(button)
    }

    @objc private func showDetailView() {
        let detailView = DetailViewController()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
