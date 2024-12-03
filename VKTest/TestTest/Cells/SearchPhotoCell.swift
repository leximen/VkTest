//
//  SearchPhotoCell.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

class SearchPhotoCell: UICollectionViewCell {
    
    let photoSearchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoSearchImage.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func photoImageView() {
        addSubviews(photoSearchImage)
        
        photoSearchImage.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            photoSearchImage.topAnchor.constraint(equalTo: self.topAnchor),
            photoSearchImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoSearchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoSearchImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

