//
//  ImageDownloader.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    var downloadTask: URLSessionDataTask?
    
    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
        downloadTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(UIImage(data: data), response, error)
            } else {
                completion(nil, response, error)
            }
        }
        downloadTask?.resume();
    }
    
    func cancel() {
        guard let task = downloadTask else {
            return
        }
        task.cancel()
    }
}
