//
//  NewsCell.swift
//  NYTimes
//
//  Created by Ahmet Acar on 24.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    static let cellId = "NewsCell"
    
    let thumbnailImage = NYTThumbnailImageView(frame: .zero)
    let titleLabel = NYTTitleLabel(fontSize: 19) // content title label
    let sectionLabel = NYTBodyLabel(textAlignment: .left, fontSize: 14) // section category label
    let dateLabel = NYTSubheadLabel(textAlignment: .right, fontSize: 10) // date label
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(results: Results) {
        
        titleLabel.text = results.title
        sectionLabel.text = results.section
        dateLabel.text = results.publishedDate
        
        if let safeImage = results.multimedia?[0].url {
            NetworkManager.shared.downloadImage(from: safeImage) { [weak self] (image) in
                DispatchQueue.main.async { self?.thumbnailImage.image = image }
            }
        } else {
            self.thumbnailImage.image = UIImage(named: Images.newsThumbnail)
        }
         
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func configure() {
        
        addSubview(thumbnailImage)
        addSubview(titleLabel)
        addSubview(stackView)
        
        let padding: CGFloat = 6.0
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //thumbnailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImage.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            //thumbnailImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            thumbnailImage.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding)
        ])
    }
    
}
