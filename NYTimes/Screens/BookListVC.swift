//
//  BookListVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 5.02.2021.
//

import UIKit

class BookListVC: UIViewController, UITableViewDelegate {
    
    enum Section {
        case main
    }
    
    var bookList: [BookInfo] = []
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, BookInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addNavBarImage()
        configureTableView()
        getBooks()
        configureDataSource()
        configureCustomFooter()
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.tintColor = UIColor(named: Colors.blackToWhite)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addNavBarImage() {
        let logo = UIImage(named: Images.navigationBarLogo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        navigationItem.titleView = imageView
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.rowHeight = 235
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(BooksCell.self, forCellReuseIdentifier: BooksCell.cellId)
    }
    
    private func configureCustomFooter() {
        let footerView = FooterView(frame: .zero)
        tableView.tableFooterView = footerView
    }
    
    func updateFooterViewHeight(for footer: UIView?) {
        guard let footer = footer else { return }
        footer.frame.size.height = footer.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 16.0, height: 0)).height
    }
    
    private func getBooks() {
        NetworkManager.shared.getLists { result in
            switch result {
            case .success(let books):
                self.bookList.append(contentsOf: books.results.lists[0].books!) //
                self.updateData(on: self.bookList)
            case .failure(let error):
                print(error)
            }

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = BookInfoVC()
        destinationVC.bookInfo = bookList[indexPath.row]
        
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true, completion: nil)
        
        //navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    //MARK: - DiffableDataSource
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, BookInfo>(tableView: tableView, cellProvider: { (tableView, indexPath, bookInfo) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BooksCell.cellId) as! BooksCell
            cell.set(books: bookInfo)
            
            return cell
        })
    }
    
    private func updateData(on books: [BookInfo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(books)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
}

