//
//  BookInfoView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 10.02.2021.
//

import UIKit

class BookInfoView: UIView {

    let stackView = UIStackView()
    let titleLabel = NYTTitleLabel(fontSize: 14)
    let descriptionLabel = NYTBodyLabel(textAlignment: .left, fontSize: 12)

    var authorName: String!
    var createdDate: String!
    var publisherName: String!
    var rankLastWeek: String!
    var rank: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackUI()
        configureStackUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(bookInfo: BookInfo) {
        super.init(frame: .zero)
        
        titleLabel.text = bookInfo.title
        descriptionLabel.text = bookInfo.description
        authorName = bookInfo.author
        createdDate = bookInfo.createdDate
        publisherName = bookInfo.publisher
        rankLastWeek = String(format: "%d", bookInfo.rankLastWeek ?? "First Week")
        rank = String(bookInfo.rank)
        
        
        configureUI()
        configureStackUI()
    }
    
    private func configureUI() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(stackView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            //stackView.heightAnchor.constraint(equalToConstant: 26),
        ])
    }
    
    private func configureStackUI() {
        let authorNameStack = NYTStackView(leftLabel: "Author:", rightLabel: authorName)
        let createdDateStack = NYTStackView(leftLabel: "Created Date:", rightLabel: createdDate)
        let publisherNameStack = NYTStackView(leftLabel: "Publisher Name:", rightLabel: publisherName)
        let rankLastWeekStack = NYTStackView(leftLabel: "Last Week Rank:", rightLabel: rankLastWeek)
        let rankStack = NYTStackView(leftLabel: "Rank:", rightLabel: rank)
        
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(createdDateStack)
        stackView.addArrangedSubview(authorNameStack)
        stackView.addArrangedSubview(publisherNameStack)
        stackView.addArrangedSubview(rankLastWeekStack)
        stackView.addArrangedSubview(rankStack)
    }
}
