//
//  ViewController.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let label = UILabel()
        label.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        label.text = "123123"

        self.view.addSubview(label)

    }

}
