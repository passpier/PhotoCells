//
//  GalleryController.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation

class GalleryController {
    let photoApiRequester: PhotoApiRequester
    let viewModel: GalleryViewModel
    
    init(viewModel: GalleryViewModel = GalleryViewModel(), photoApiRequester: PhotoApiRequester = PhotoApiRequester()) {
        self.viewModel = viewModel
        self.photoApiRequester = photoApiRequester
    }
    
    func startFetch() {
        self.viewModel.isLoading.value = true
        self.viewModel.isCollectionViewHidden.value = true
        photoApiRequester.fetchPhotos {[weak self] (photos, response, error) in
            DispatchQueue.main.async {
                self?.viewModel.isLoading.value = false
                self?.viewModel.isCollectionViewHidden.value = false
                self?.viewModel.collectionViewModel.value = photos.map {(photo) in
                    return PhotoCellViewModel(id: photo.id.stringValue, title: photo.title, asyncImage: AsyncImage(url: photo.thumbnailUrl))
                }
            }
        }
    }
}
