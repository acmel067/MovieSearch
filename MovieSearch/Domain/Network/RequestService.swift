//
//  RequestService.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/27/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import UIKit

final class RequestService {
    
    static let shared = RequestService()
    
    private init() {}
    
    public func fetchData<T: Decodable>(url: URL?, type: T.Type, method: RequestFactory.Method, completion:  @escaping ((Result<T, Error>)-> Void)) {
        
        guard let url = url else {
            return;
        }
        
        let request = RequestFactory.request(method: method, url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let data {
                if let parsedObject = Parser.parse(type: type, data: data) {
                    completion(.success(parsedObject))
                } else {
                    // To do: Error
//                    completion(.failure(Error()))
                }
            }
        }.resume()
    }
    
    public func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        DispatchQueue.global().async {
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error downloading image: \(error)")
                        completion(nil)
                    } else if let data = data {
                       completion(data)
                    }
                }
            }
            task.resume()
        }
    }
}
