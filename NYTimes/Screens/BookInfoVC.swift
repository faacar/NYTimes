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
        addNavBarImage() //
        configureUI()
        

    }

    let contentView = UIView()

    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        //scrollView.frame = view.bounds
        //scrollView.showsVerticalScrollIndicator = true //
        //scrollView.contentInsetAdjustmentBehavior = .never
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        scrollView.backgroundColor = .systemBackground
        //scrollView.autoresizingMask = .flexibleHeight //
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
        view.frame.size = CGSize(width: self.view.frame.width, height: (3 * self.view.frame.height))
        return view
    } ()
    
    lazy var bookBuySectionView: BookInfoBuyView = {
        let view = BookInfoBuyView(buyLinks: bookInfo.buyLinks)
        view.frame.size = CGSize(width: self.view.frame.width, height: UIScreen.main.bounds.width)
        return view
    } ()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quiSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quiSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, qui"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.systemPink
        label.backgroundColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configureUI() {
        
        bookInfoHeaderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        bookInfoDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        bookBuySectionView.translatesAutoresizingMaskIntoConstraints = false
        
        bookBuySectionView.backgroundColor = .cyan
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookInfoHeaderView)
        contentView.addSubview(bookInfoDescriptionView)
        contentView.addSubview(bookBuySectionView)
//        contentView.addSubview(subtitleLabel)

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
            
//            bookBuySectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            bookBuySectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/10),
            bookBuySectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookBuySectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            bookBuySectionView.topAnchor.constraint(equalTo: bookInfoDescriptionView.bottomAnchor),
            bookBuySectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            

//            subtitleLabel.topAnchor.constraint(equalTo: bookInfoDescriptionView.bottomAnchor, constant: padding),
//            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            
        ])
    }
    
    private func addNavBarImage() {
        let logo = UIImage(named: Images.navigationBarLogo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        navigationItem.titleView = imageView
    }
}
