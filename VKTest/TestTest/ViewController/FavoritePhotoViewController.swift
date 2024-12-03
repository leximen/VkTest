//
//  FavoritePhotoViewController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

class FavoritePhotoViewController: UIPhotoCollectionViewController {
    private var favoriteArray: [UnsplashResult] = FavoriteDataModel.shared.getFavoriteArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранные"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteArray = FavoriteDataModel.shared.getFavoriteArray()
        reloadData()
    }
}


extension FavoritePhotoViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCell.identifier, for: indexPath) as? SearchPhotoCell else {
            fatalError("Not registration cell UICollectionViewCell")
        }
        
        if let string = favoriteArray[indexPath.item].urls?.small,
           let url = URL(string: string) {
            cell.photoSearchImage.sd_setImage(with: url)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = favoriteArray[indexPath.item]
        let vc = InformationPhotoViewController(unsplush: value)
        navigationController?.pushViewController(vc, animated: true)
    }
}

