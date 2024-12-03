//
//  UIView-Ext.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            
            let color = UIColor(cgColor: cgColor)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
