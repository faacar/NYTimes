//
//  BookInfoBuyView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 10.02.2021.
//

import UIKit

class BookInfoBuyView: UIView {

    let companyName = ["Amazon" : Logos.amazon,"Apple Books" : Logos.appleBooks,"Barnes and Noble" : Logos.barnesAndNoble, "Books-A-Million" :Logos.booksAMillion, "Bookshop" : Logos.bookShop, "Indiebound" : Logos.indeBound]
    var info: [BuyLinks]!
    var links = [String: String]()
    lazy var widthSize: CGFloat = (UIScreen.main.bounds.width - 16) / 8
    var count = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(buyLinks: [BuyLinks]) {
        super.init(frame: .zero)
        info = buyLinks
        configureUI(buyLinks)
    }
    
    func getLogo(link: String) -> String{
        switch link {
        case "Amazon":
            return Logos.amazon
        case "Apple Books":
            return Logos.appleBooks
        case "Barnes and Noble":
            return Logos.barnesAndNoble
        case "Books-A-Million":
            return Logos.booksAMillion
        case "Bookshop":
            return Logos.bookShop
        case "Indiebound":
            return Logos.indeBound
        default:
            return Images.newsThumbnail
        }
    }
    
    func getLink(bookName: String) -> String {
        for item in links {
            if item.key == bookName {
                print("getLinkInfo:\(item.key)")
                return item.value
            }
        }
        return "https://www.nytimes.com/section/books"
    }

    private func configureUI(_ buyLinks: [BuyLinks]) {
       
        translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8.0
        
        for item in buyLinks {

            let companyImage = UIImage(named: getLogo(link: item.name))
            
            links.updateValue(item.url, forKey: item.name)
            
            let companyButton = UIButton()
            companyButton.setImage(companyImage, for: .normal)
            companyButton.setTitle(item.name, for: .normal)
            companyButton.contentMode = .scaleAspectFit
            companyButton.layer.masksToBounds = true
            companyButton.layer.cornerRadius = 16.0
            companyButton.addTarget(self, action: #selector(companyButtonClicked), for: .touchUpInside)
            

            addSubview(companyButton)
            companyButton.translatesAutoresizingMaskIntoConstraints = false
            
            if count <= 3 {
                NSLayoutConstraint.activate([
                    companyButton.topAnchor.constraint(equalTo: self.topAnchor,constant: padding),
                    companyButton.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16) / 5),
                    companyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthSize),
                    companyButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (1/5)),
                ])

            } else {
                if count == 4 { widthSize = UIScreen.main.bounds.width / 8 }
                NSLayoutConstraint.activate([
                    companyButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 95),
                    companyButton.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16) / 5),
                    companyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                    companyButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (1/5)),
                    companyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthSize),
                ])
            }

            count += 1
            widthSize += ((UIScreen.main.bounds.width - 16) / 4) + 8

        }
    }
    
    @objc func companyButtonClicked(sender: UIButton) {
        let url = URL(string: getLink(bookName: sender.currentTitle!))
        UIApplication.shared.open(url!)
    }
}
