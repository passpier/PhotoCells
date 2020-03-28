//
//  GalleryViewModel.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/27.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation

class GalleryViewModel {
    let isLoading = Observable<Bool>(value: false)
    let isCollectionViewHidden = Observable<Bool>(value: false)
    let collectionViewModel = Observable<[PhotoCellViewModel]>(value: [])
}
