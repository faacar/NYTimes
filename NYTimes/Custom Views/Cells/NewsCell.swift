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
    let titleLabel = NYTTitleLabel(fontSize: 18) // content title label
    let sectionLabel = NYTBodyLabel(textAlignment: .left, fontSize: 12) // section category label
    let dateLabel = NYTSubheadLabel(textAlignment: .right, fontSize: 9) // date label
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
        dateLabel.text = results.publishedDate.convertToDisplayFormat()
        
        if let safeImage = results.multimedia?[2].url {
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
        //stackView.spacing = 2
        
        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func configure() {
        addSubview(thumbnailImage)
        addSubview(stackView)
        addSubview(titleLabel)
        
        let padding: CGFloat = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            thumbnailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            thumbnailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            thumbnailImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            
            stackView.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding / 2),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
}
