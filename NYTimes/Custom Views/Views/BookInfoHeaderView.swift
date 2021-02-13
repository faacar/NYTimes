//
//  BookInfoHeaderView.swift
//  NYTimes
//
//  Created by Ahmet Acar on 10.02.2021.
//

import UIKit

class BookInfoHeaderView: UIView {

    let bookImageView = UIImageView(frame: .zero)
    let circleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    init(bookImage: String) {
        super.init(frame: .zero)
        NetworkManager.shared.downloadImage(from: bookImage) { (image) in
            DispatchQueue.main.async { self.bookImageView.image = image }
        }
        circleImageView.image = UIImage(named: "halfCircleS")
        
        configureUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        //addSubview(bookImageView)
        insertSubview(bookImageView, at: 1)
        insertSubview(circleImageView, at: 0)
        
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8.0
        
        
        NSLayoutConstraint.activate([
            
            bookImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -18),
            bookImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            bookImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            circleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2 * -padding)
        ])
    }
}
