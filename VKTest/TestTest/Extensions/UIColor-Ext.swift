//
//  UIColor-Ext.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit.UIColor

extension UIColor {
    
    class var custom: CustomColor.Type { return CustomColor.self }
    
    class CustomColor {
        class var white: UIColor { return UIColor(named: "white") ?? .white }
        class var blue: UIColor { return UIColor(named: "blue") ?? .systemBlue}
    }
}
