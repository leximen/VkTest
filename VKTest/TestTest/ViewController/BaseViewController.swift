//
//  BaseViewController.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backButtonTitle = ""
        }
    }
}
