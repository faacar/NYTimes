//
//  ListCell.swift
//  NYTimes
//
//  Created by Ahmet Acar on 3.02.2021.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let cellId = "ListCell"

    let listCategoryTitle = NYTTitleLabel(fontSize: 19)
    let categoryBookThumbnail = NYTThumbnailImageView(frame: .init(x: 0, y: 0, width: 184.0, height: 100.0))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(lists bookLists: BookLists) {
        listCategoryTitle.text = bookLists.displayName
        
        if let safeImage = bookLists.listImage {
            NetworkManager.shared.downloadImage(from: safeImage) { (image) in
                DispatchQueue.main.async { self.categoryBookThumbnail.image = image }
            }
        } else {
            self.categoryBookThumbnail.image = UIImage(named: Images.newsThumbnail)
        }
    }
    
    private func configure() {
        addSubview(categoryBookThumbnail)
        
        addSubview(listCategoryTitle)
        let padding: CGFloat = 8.0
        
        NSLayoutConstraint.activate([
            categoryBookThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            categoryBookThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            categoryBookThumbnail.heightAnchor.constraint(equalToConstant: 184),
            categoryBookThumbnail.widthAnchor.constraint(equalToConstant: 120),
            
            listCategoryTitle.leadingAnchor.constraint(equalTo: categoryBookThumbnail.trailingAnchor, constant: 6.0),
            listCategoryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            listCategoryTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
}
