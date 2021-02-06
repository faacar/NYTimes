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
        getLists()
        configureDataSource()
        configureCustomFooter()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFooterViewHeight(for: tableView.tableFooterView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*
            // moved to top
            print("move Up\(scrollView.contentOffset.y)")
            print("alpha\(Float(scrollView.contentOffset.y / 166))")
            navigationController?.navigationBar.alpha = scrollView.contentOffset.y / 166
            if Float(scrollView.contentOffset.y / 166) >= 1.0 {

                    self.navigationController?.navigationBar.isTranslucent = false

                    }

            // moved to bottom

            navigationController?.navigationBar.alpha = scrollView.contentOffset.y / 166
            print("alpha\(Float(scrollView.contentOffset.y / 166))")
            print("move down\(scrollView.contentOffset.y)")
*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bookList = self.dataSource.itemIdentifier(for: indexPath) else { return }
        let destinationVC = BookListVC()
        destinationVC.bookList = bookList.books! // can be throw error
        
        //let navigationController = UINavigationController(rootViewController: destinationVC)
        //present(navigationController, animated: true, completion: nil)
        navigationController?.pushViewController(destinationVC, animated: true)        
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: Fonts.domineBold, size: 45.0)!]
        navigationController?.title = "Category"
        navigationItem.title = "Category"
    }
    
    private func addNavBarImage() {
        let logo = UIImage(named: Images.navigationBarLogo)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .center
        navigationItem.titleView = imageView
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.rowHeight = 200
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.cellId)
    }
    
    private func configureCustomFooter() {
        let footerView = FooterView(frame: .zero)
        tableView.tableFooterView = footerView
    }
    
    func updateFooterViewHeight(for footer: UIView?) {
        guard let footer = footer else { return }
        footer.frame.size.height = footer.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 16.0, height: 0)).height
    }
    
    private func getLists() {
        NetworkManager.shared.getLists { result in
            
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
