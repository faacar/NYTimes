//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let newsBaseURL = "https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key="
    private let booksBaseURL = "https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key="
    private let apiKey = "lpFTUcLHsCC7r5sprgGGdzyhfA22GZ80"
    let cache = NSCache<NSString, UIImage>()
    
    private init () { }
    
    func getNews(completionHandler: @escaping (Result<News, NetworkingError>) -> Void) {
        let endPoint = "\(newsBaseURL)\(apiKey)"
        
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.connectionProblem))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let news = try decoder.decode(News.self, from: data)
                completionHandler(.success(news))
                
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getLists(completionHandler: @escaping (Result<Books, NetworkingError>) -> Void) {
        let endPoint = "\(booksBaseURL)\(apiKey)"

        guard let url = URL(string: endPoint) else {
            completionHandler(.failure(.connectionProblem))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let books = try decoder.decode(Books.self, from: data)
                completionHandler(.success(books))

            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        //print("download image test")
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { // if we have a cache image dont go any deep
            completionHandler(image)
            return
        }// if not download the image
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completionHandler(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey) // set image into the cache
            completionHandler(image)
        }
        task.resume()
    }

}
