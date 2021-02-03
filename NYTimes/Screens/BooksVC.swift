//
//  BooksVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import UIKit

class BooksVC: UIViewController, UITableViewDelegate {

    enum Section {
        case main
    }
    
    var bookLists: [BookLists] = []
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, BookLists>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addNavBarImage()
        configureTableView()
        getBooks()
        configureDataSource()
        configureCustomFooter()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFooterViewHeight(for: tableView.tableFooterView)
    }
    
    private func configureViewController() {
        
    }
    
    private func addNavBarImage() {
        let logo = UIImage(named: Images.navigationBarLogo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        navigationItem.titleView = imageView
    }
    
    private func configureTableView() {
        

 
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
        NetworkManager.shared.getBooks { result in
            
            switch result {
            case .success(let books):
                self.bookLists.append(contentsOf: books.results.lists)
                self.updateData(on: self.bookLists)
            case .failure(let error):
                print(error)
            }

        }
    }
    
    //MARK: - DiffableDataSource

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, BookLists>(tableView: tableView, cellProvider: { (tableView, indexPath, bookLists) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.cellId) as! ListCell
            cell.set(lists: bookLists)
            
            return cell
        })
    }
    
    private func updateData(on lists: [BookLists]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BookLists>()
        snapshot.appendSections([.main])
        snapshot.appendItems(lists)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }


}
