//
//  NewsVC.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import UIKit

class NewsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getNews()
    }
    
    func getNews() {
        NetworkManager.shared.getNews { result in
            
            switch result {
            case .success(let news):
                print(news.results[0].title)
                print(news.results[1].title)
            case .failure(let error):
                print(error)
            }
        }
    }
    

    

}
