//
//  NewsVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import UIKit
import SafariServices

class NewsVC: UIViewController {

    enum Section {
        case main
    }
    
    var results: [NewsResults] = []
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, NewsResults>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addNavBarImage()
        configureTableView()
        getNews()
        configureDataSource()
        configureCustomFooter()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFooterViewHeight(for: tableView.tableFooterView)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemOrange
        navigationController?.isNavigationBarHidden = false
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
        tableView.rowHeight = 320
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellId)

    }
    
    private func configureCustomFooter() {
        let footerView = FooterView(frame: .zero)
        tableView.tableFooterView = footerView
    }
    
    func updateFooterViewHeight(for footer: UIView?) {
        guard let footer = footer else { return }
        footer.frame.size.height = footer.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 16.0, height: 0)).height
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        guard let url = URL(string: linkItem.url) else { return }
            let vc = SFSafariViewController(url: url)
            print(url)
            vc.delegate = self

            present(vc, animated: true)
    }
    
    //MARK: - DiffableDataSource
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, NewsResults>(tableView: tableView, cellProvider: { (tableView, indexPath, results) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellId, for: indexPath) as! NewsCell
            cell.set(results: results)
            
            return cell
        })
        
    }
    
    func updateData(on results: [NewsResults]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, NewsResults>()
        snapshot.appendSections([.main])
        snapshot.appendItems(results)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
}
    //MARK: - Extensions UITableViewDelegate

extension NewsVC: UITableViewDelegate {
    
}
    //MARK: SFSafariViewControllerDelegate
extension NewsVC: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
