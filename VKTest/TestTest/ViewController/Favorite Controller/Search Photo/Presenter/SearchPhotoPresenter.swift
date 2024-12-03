//
//  SearchPhotoPresenter.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import Foundation

protocol SearchPhotoPresenterProtocol: AnyObject {
    func reloadData()
    func error(_ title: String?, message: String)
    func pushDetealViewController(_ unsplafData: UnsplashResult)
}

final class SearchPhotoPresenter {
    weak var delegate: SearchPhotoPresenterProtocol?
    
    private var timer: Timer?
    private var textForSearch: String = ""
    private var page: Int = 1
    private var totalPage: Int?
    
    private (set) var resultArray = [UnsplashResult]()
    
    private func loadingFirstPageResult(_ text: String) {
        self.textForSearch = text
        
        Network.shared.getPhotos(search: text, page: 1) { [weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                guard let totalPage = success.total_pages,
                      let array = success.results else { return }
                
                self.totalPage = totalPage
                
                if !array.isEmpty { self.page += 1 }
                
                self.resultArray = array
                self.reloadData()
               
            case.failure(let failure):
                self.errorResult(failure)
            }
        }
    }

    func serchEditing(_ text: String) {
        totalPage = nil
        page = 1
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { timer in
            self.loadingFirstPageResult(text)
            timer.invalidate()
        })
    }
    
    func getPage() {
        if page > totalPage ?? 0, textForSearch.isEmpty { return }
        
        Network.shared.getPhotos(search: textForSearch, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                guard let array = success.results else { return }
                
                if !array.isEmpty { self.page += 1 }
                
                self.resultArray += array
                
                self.reloadData()
                
            case .failure(let failure):
                
                self.errorResult(failure)
            }
        }
    }
    
    func didSelectItem(_ item: Int) {
        let value = resultArray[item]
        delegate?.pushDetealViewController(value)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.delegate?.reloadData()
        }
    }
    
    private func errorResult(_ error: ErrorNetwork) {
        DispatchQueue.main.async {
            self.delegate?.error("Error", message: error.description)
        }
    }
}

