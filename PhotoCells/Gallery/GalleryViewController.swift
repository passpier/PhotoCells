//
//  GalleryViewController.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    var viewModel: GalleryViewModel {
        return controller.viewModel
    }
    
    lazy var controller: GalleryController = {
       return GalleryController()
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        
        self.view.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: self.view.topAnchor),
            cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return cv
    }()
    
    lazy var loadingIdicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
        controller.startFetch()
    }
    
    func initBinding() {
        viewModel.collectionViewModel.addObserver(fireNow: false) { [weak self] (collectionViewModel) in
            self?.collectionView.reloadData()
        }
        
        viewModel.isCollectionViewHidden.addObserver { [weak self] (isHidden) in
            self?.collectionView.isHidden = isHidden
        }
        
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.loadingIdicator.startAnimating()
            } else {
                self?.loadingIdicator.stopAnimating()
            }
        }
    }
    

}

extension GalleryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoViewModel = viewModel.collectionViewModel.value[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.setup(viewModel: photoViewModel);
        cell.layoutIfNeeded()
        return cell
    }
}
