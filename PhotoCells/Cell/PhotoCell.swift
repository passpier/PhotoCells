//
//  PhotoCell.swift
//  PhotoCells
//
//  Created by vincent cheng on 2020/3/28.
//  Copyright © 2020 PSC. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    lazy var bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        self.contentView.addSubview(iv)
        return iv
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        self.contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bg.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            idLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -40),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: PhotoCellViewModel?
    
    func setup(viewModel: PhotoCellViewModel) {
        self.viewModel = viewModel
        self.idLabel.text = viewModel.id
        self.titleLabel.text = viewModel.title
        self.bg.image = viewModel.asyncImage.image
        
        viewModel.asyncImage.startDownload()
        viewModel.asyncImage.completeDownload = { [weak self] image in
            self?.bg.image = image
        }
        
        setNeedsLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.asyncImage.completeDownload = nil
        viewModel?.asyncImage.cancelDownload()
    }
}
