//
//  BooksCell.swift
//  NYTimes
//
//  Created by Ahmet Acar on 5.02.2021.
//

import UIKit

class BooksCell: UITableViewCell {
    
    static let cellId = "BooksCell"
    /*
    let createdDateLabel = NYTSubheadLabel(textAlignment: .right, fontSize: 14)
    let publisherLabel = NYTSubheadLabel(textAlignment: .left, fontSize: 14)
    let lastWeekRankLabel = NYTSubheadLabel(textAlignment: .right, fontSize: 13)
    
    //let firstStackView = BookBuyLinkStackView
    */
    let bookNameLabel = NYTTitleLabel(fontSize: 18)
    let bookCoverImage = NYTThumbnailImageView(frame: .zero)
    let authorNameLabel = NYTSubheadLabel(textAlignment: .left, fontSize: 14)
    let rankLabel = UILabel(frame: .zero)
    let rankLabelConstant = NYTBodyLabel(textAlignment: .center, fontSize: 16)
    let bookDescriptionLabel = NYTBodyLabel(textAlignment: .left, fontSize: 17)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(books: BookInfo) {
        let safeImage = books.bookImage
        
        
        let amountText = NSMutableAttributedString.init(string: makeOrdinalStringNumbers(number: books.rank))
        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50),
                                  NSAttributedString.Key.foregroundColor: UIColor(named: Colors.blackToWhite)!],
                                     range: NSMakeRange(0, 1))
        
        rankLabel.attributedText = amountText
        bookNameLabel.text = books.title
        authorNameLabel.text = books.author
        rankLabelConstant.text = "Rank:"
        bookDescriptionLabel.text = books.description
        
        NetworkManager.shared.downloadImage(from: safeImage) { (image) in
            DispatchQueue.main.async { self.bookCoverImage.image = image }
        }
    }
    
    private func makeOrdinalStringNumbers(number: Int) -> String {
        
        var stringOrdinalNumber: String
        
        switch number {
        case 1:
            stringOrdinalNumber = "1st"
            break
        case 2:
            stringOrdinalNumber = "2nd"
            break
        case 3:
            stringOrdinalNumber = "3rd"
            break
        default:
            stringOrdinalNumber = "\(number)th"
            break
        }
        
        return stringOrdinalNumber
    }
    
    private func configure() {
        
        rankLabel.textAlignment = .center
        rankLabel.adjustsFontSizeToFitWidth = false
        rankLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.textColor = .systemGray
                
        addSubview(bookCoverImage)
        addSubview(rankLabel)
        addSubview(bookNameLabel)
        addSubview(authorNameLabel)
        addSubview(bookDescriptionLabel)
        //addSubview(rankLabelConstant)
        
        let padding: CGFloat = 8.0
        let totalWidth = contentView.bounds.width
        let width = totalWidth / 8

        NSLayoutConstraint.activate([
            bookCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            bookCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookCoverImage.heightAnchor.constraint(equalToConstant: 184),
            bookCoverImage.widthAnchor.constraint(equalToConstant: 3 * width),
            
            bookNameLabel.topAnchor.constraint(equalTo: bookCoverImage.topAnchor),
            bookNameLabel.leadingAnchor.constraint(equalTo: bookCoverImage.trailingAnchor, constant: 3.0),
            bookNameLabel.widthAnchor.constraint(equalToConstant: 5 * width),
            bookNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            rankLabelConstant.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
//            rankLabelConstant.leadingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor),
//            rankLabelConstant.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
//            rankLabelConstant.heightAnchor.constraint(equalToConstant: 20),
            
//            rankLabel.topAnchor.constraint(equalTo: rankLabelConstant.bottomAnchor, constant: 3.0),
            rankLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            rankLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            rankLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2 * -padding),
            rankLabel.leadingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor),
            
            bookDescriptionLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: padding),
            bookDescriptionLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor),
            bookDescriptionLabel.trailingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor),
            bookDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            authorNameLabel.topAnchor.constraint(equalTo: bookCoverImage.bottomAnchor, constant: 3),
            authorNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            authorNameLabel.trailingAnchor.constraint(equalTo: bookDescriptionLabel.leadingAnchor, constant: -padding),
            authorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
            
        ])
    }
}
