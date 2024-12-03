//
//  FavoriteDataModel.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import Foundation

class FavoriteDataModel {
    private let kay: String = "FavariteDataKeyForMemory"
    static let shared: FavoriteDataModel = .init()
    
    private var favoriteArray: [UnsplashResult] = []
    
    private init() {
        
        guard let data = UserDefaults.standard.data(forKey: kay),
              let array = try? JSONDecoder().decode([UnsplashResult].self, from: data)
        else { return }
        
        favoriteArray = array
    }
    
    private func updateDB() {
        let data = try? JSONEncoder().encode(favoriteArray)
        UserDefaults.standard.setValue(data, forKey: kay)
        UserDefaults.standard.synchronize()
    }
    
}

extension FavoriteDataModel {

    func getFavoriteArray() -> [UnsplashResult] {
        return favoriteArray
    }
    
    func didSelect(_ value: UnsplashResult) -> Bool {
        if let index = favoriteArray.firstIndex(where: { element in
            element.id == value.id
        }) {
            favoriteArray.remove(at: index)
            updateDB()
            return false
        }
        
        favoriteArray.append(value)
        updateDB()
        return true
    }
    
    func isOnFavorite(_ id: String) -> Bool {
        if let _ = favoriteArray.firstIndex(where: { element in
            element.id == id
        }) {
            return true
        }
        
        return false
    }
}

