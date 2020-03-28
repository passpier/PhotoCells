//
//  PhotoCellViewModel.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import Foundation

class PhotoCellViewModel {
    
    let id: String
    let title: String
    let asyncImage: AsyncImage
    
    init(id: String, title: String, asyncImage: AsyncImage) {
        self.id = id
        self.title = title
        self.asyncImage = asyncImage
    }
}
