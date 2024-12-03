//
//  UIPhotoCollectionViewController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

class UIPhotoCollectionViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SearchPhotoCell.self, forCellWithReuseIdentifier: SearchPhotoCell.identifier)

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubviews(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension UIPhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let countCell: CGFloat = 2
        
        let spacing: CGFloat = 5
        
        let indent: CGFloat = 15
        
        let widthCV = collectionView.bounds.width
        
        let fullCellWidth = widthCV - indent * 2 - (spacing * countCell - 1)
       
        let width = fullCellWidth / countCell
        
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}

extension UIPhotoCollectionViewController {
    func reloadData() {
        collectionView.reloadData()
    }
}

