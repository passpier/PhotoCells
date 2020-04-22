//
//  AsyncImage.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation
import UIKit

class AsyncImage {
    
    let url: URL
    var image: UIImage {
        return self.imageStore ?? placeholder
    }
    
    var completeDownload: ((UIImage?) -> Void)?
    
    private var imageStore: UIImage?
    private var placeholder: UIImage
    
    private let imageDownloader: ImageDownloader
    
    private var isDownloading: Bool = false
    
    init(url: String, imageDownloader: ImageDownloader = ImageDownloader()) {
        self.url = URL(string: url)!
        self.placeholder = UIImage()
        self.imageDownloader = imageDownloader
    }
    
    func startDownload() {
        if imageStore != nil {
            completeDownload?(image)
        } else {
            if isDownloading { return }
            isDownloading = true
            imageDownloader.download(url: url) { [weak self] (image, response, error) in
                self?.imageStore = image
                self?.isDownloading = false
                DispatchQueue.main.async {
                    self?.completeDownload?(image)
                }
            }
        }
    }
   
    func cancelDownload() {
        if isDownloading {
            imageDownloader.cancel()
            isDownloading = false
        }
    }
    
    deinit {
        print("\(url) AsyncImage deinitialized")
    }
}
