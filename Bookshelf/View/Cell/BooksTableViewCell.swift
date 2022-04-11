//
//  BooksTableCell.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

class BooksTableViewCell: UITableViewCell {

    var img = UIImageView()
    var title = UILabel()

    override func prepareForReuse() {
        self.title.text = ""
        self.img.image = nil
    }

    private func setConstraint() {
        contentView.addSubview(img)
        contentView.addSubview(title)
        contentView.backgroundColor = .white

        img.anchor(top: contentView.topAnchor, right: nil, bottom: contentView.bottomAnchor, left: contentView.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 80, height: 80))

        title.anchor(top: contentView.topAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, left: img.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0 ))
        title.textColor = .black
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
