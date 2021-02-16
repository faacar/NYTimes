//
//  BookInfoVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 7.02.2021.
//

import UIKit

class BookInfoVC: UIViewController {

    var bookInfo: BookInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addNavBarImage() //
        configureNavigation()
        configureUI()
    }

    let contentView = UIView()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .systemBackground
        return scrollView
    } ()
    
    lazy var bookInfoHeaderView: BookInfoHeaderView = {
        let view = BookInfoHeaderView(bookImage: bookInfo.bookImage)
        //view.backgroundColor = .systemBlue
        view.frame.size = CGSize(width: self.view.frame.width, height: (2 * self.view.frame.height) / 5)
        return view
    } ()
    
    lazy var bookInfoDescriptionView: BookInfoView = {
        let view = BookInfoView(bookInfo: bookInfo)
        view.frame.size = CGSize(width: self.view.frame.width, height: (2.5 * self.view.frame.height))
        return view
    } ()
    
    lazy var buyBookLabel: NYTTitleLabel = {
        let label = NYTTitleLabel(fontSize: 22)
        label.text = "Buy Book"
        return label
    } ()
    
    lazy var bookBuySectionView: BookInfoBuyView = {
        let view = BookInfoBuyView(buyLinks: bookInfo.buyLinks)
        view.frame.size = CGSize(width: self.view.frame.width, height: UIScreen.main.bounds.width)
        view.backgroundColor = Colors.backgroundColor
        view.layer.cornerRadius = 12.0
        view.layer.masksToBounds = true
        return view
    } ()
    
    private func configureUI() {
        bookInfoHeaderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        bookInfoDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        buyBookLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        bookBuySectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookInfoHeaderView)
        contentView.addSubview(bookInfoDescriptionView)
        contentView.addSubview(buyBookLabel)
        contentView.addSubview(bookBuySectionView)

        let padding: CGFloat = 8.0
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bookInfoHeaderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookInfoHeaderView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bookInfoHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookInfoHeaderView.heightAnchor.constraint(equalToConstant: 358),
            
            bookInfoDescriptionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookInfoDescriptionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bookInfoDescriptionView.topAnchor.constraint(equalTo: bookInfoHeaderView.bottomAnchor, constant: padding),
            bookInfoDescriptionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/5),
            
            buyBookLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            buyBookLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            buyBookLabel.topAnchor.constraint(equalTo: bookInfoDescriptionView.bottomAnchor),
            buyBookLabel.heightAnchor.constraint(equalToConstant: 40),
            
            bookBuySectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookBuySectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bookBuySectionView.topAnchor.constraint(equalTo: buyBookLabel.bottomAnchor, constant: padding),
            bookBuySectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func addNavBarImage() {
        let logo = UIImage(named: Images.navigationBarLogo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        navigationItem.titleView = imageView
    }
    
    private func configureNavigation() {
        view.backgroundColor = Colors.backgroundColor
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.rightBarButtonItem?.tintColor = Colors.backgroundColor
//        navigationItem.title = bookInfo.title
        navigationItem.title = "Books Info"
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
