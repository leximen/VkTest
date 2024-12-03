//
//  TabBarController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

class TabBarController: UITabBarController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        viewControllers = [
            setupController(title: "Фото", nameImage: "photo", vc: SearchPhotoViewController.self),
            setupController(title: "Избранные", nameImage: "hand.thumbsup.fill", vc: FavoritePhotoViewController.self)
        ]
    }
    
    private func setupController(title: String? = nil, nameImage: String, vc: UIViewController.Type) -> UINavigationController {
        
        let navigationController = UINavigationController(rootViewController: vc.init())
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: nameImage)
        
        return navigationController
    }
}

