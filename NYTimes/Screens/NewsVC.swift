//
//  NewsVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import UIKit

class NewsVC: UIViewController {

    enum Section {
        case main
    }
    
    var news: [News] = []
    var results: [Results] = []
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Results>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNews()
        configureDataSource()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemOrange
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.rowHeight = 320
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)
    }
    
    func getNews() {
        NetworkManager.shared.getNews { result in
            
            switch result {
            case .success(let news):
                self.results.append(contentsOf: news.results)
                self.updateData(on: self.results)
            case .failure(let error):
                print(error)
            }

        }
    }
    
    //MARK: - DiffableDataSource
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Results>(tableView: tableView, cellProvider: { (tableView, indexPath, results) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId, for: indexPath) as! NewsCell
            cell.set(results: results)
            print("indexPath:\(indexPath)")

            print("configureDatasource News:\(results)")
            return cell
        })
        
    }
    
    func updateData(on results: [Results]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Results>()
        snapshot.appendSections([.main])
        snapshot.appendItems(results)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
}

extension NewsVC: UITableViewDelegate {
    
}
