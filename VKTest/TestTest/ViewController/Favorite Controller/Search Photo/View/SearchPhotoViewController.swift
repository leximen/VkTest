//
//  SearchPhotoViewController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit
import SDWebImage

class SearchPhotoViewController: UIPhotoCollectionViewController {
    private let presenter: SearchPhotoPresenter = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo"
        searchBar()
        presenter.delegate = self
        setupNavigationItem()
    }
    
    private func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Введите название фото"
    }
    
    private func setupNavigationItem() {
        let theme = Theme.current
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: theme.image), style: .done, target: self, action: #selector(didSelectThemeAction(_:)))
    }
    
    @objc private func didSelectThemeAction(_ sender: UIBarButtonItem) {
        let current = Theme.current
        let new: Theme = current == .dark ? .light : .dark
        
        sender.image = .init(systemName: new.image)
        
        new.setActive()
    }
}

extension SearchPhotoViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.resultArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCell.identifier, for: indexPath) as? SearchPhotoCell else {
            fatalError("Not registration cell UICollectionViewCell")
        }
        
        if let string = presenter.resultArray[indexPath.item].urls?.small,
            let url = URL(string: string) {
            cell.photoSearchImage.sd_setImage(with: url)
        }
        
        let max = presenter.resultArray.count - 4
        
        if indexPath.item == max {
            presenter.getPage()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(indexPath.item)
    }
}

extension SearchPhotoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.serchEditing(searchText)
    }
}

extension SearchPhotoViewController: SearchPhotoPresenterProtocol {
 
    func error(_ title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func pushDetealViewController(_ unsplafData: UnsplashResult) {
        let vc = InformationPhotoViewController(unsplush: unsplafData)
        navigationController?.pushViewController(vc, animated: true)
    }
}

