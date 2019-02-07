//
//  itunesItemController.swift
//  AppleSearch
//
//  Created by Ben Huggins on 2/7/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit


class ItunesItemController {
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func fetchItunesItemsFor(searchTerm: String, completion: @escaping ([ItunesItem]) -> Void ) {
        guard var url = baseURL else { completion([]); return }
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm.lowercased())
        components?.queryItems = [searchTermQueryItem]
        
        guard let componentsURL = components?.url else {completion([]); return}
        let request = URLRequest(url: componentsURL)
      //  request.httpMethod = "GET"
     //   request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error fetching data \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {completion([]); return}
            
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelJSON = try jsonDecoder.decode(TopLevelJSON.self, from: data)
                let itunesItem = topLevelJSON.results
                completion(itunesItem)
              
            }catch {
                
                print("Error decoding itunes Items for \(searchTerm): \(error): \(error.localizedDescription)")
                completion([])
                return
            }
            
        }
        dataTask.resume()
        
    }
    
    static func fetchImageFor(item: ItunesItem, completion: @escaping(UIImage?) -> Void) {
        
        guard let url = URL(string: item.albumImageAsString) else { completion(nil); return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(" \(String(describing: item.albumName)) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let image = UIImage(data: data)
            completion(image)
            
            
            
        }
        
        dataTask.resume()
        
    }
    
    
}
