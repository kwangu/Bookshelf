//
//  DetailViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class DetailBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        self.title = "Detail"
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = .white
    }
}
