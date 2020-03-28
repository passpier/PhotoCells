//
//  PhotoApiRequester.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation

class PhotoApiRequester {
    
    let baseUrl = "https://jsonplaceholder.typicode.com"
    
    func fetchPhotos(completion: @escaping ([Photo], URLResponse?, Error?) -> ()) {
        
        let photosUrl = URL(string: baseUrl + "/photos");
        URLSession.shared.dataTask(with: photosUrl!) { (data, response, error) in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                    let photos: [Photo] = jsonArray.map { item in
                        let jsonItem = item as! NSDictionary
                        return Photo(id: jsonItem.object(forKey: "id") as! NSNumber, title: jsonItem.object(forKey: "title") as! String, thumbnailUrl: jsonItem.object(forKey: "thumbnailUrl") as! String)
                    }
                    completion(photos, response, error)
                } catch {
                    completion([], response, error)
                }
            } else {
                completion([], response, error)
            }
        }.resume()
    }
}
