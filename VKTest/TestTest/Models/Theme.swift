//
//  Theme.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import UIKit

enum Theme: Int, CaseIterable {
    case light = 0
    case dark = 1
    
    var nameButton: String {
        switch self {
        case .light: return "Светлая"
        case .dark: return "Темная"
        }
    }
    
    var image: String {
        switch self {
        case .light: return "sun.min"
        case .dark: return "moon"
        }
    }
}

extension Theme {
    
    @Persist(key: "app_theme", defaultValue: Theme.light.rawValue)
    private static var appTheme: Int
    
    func save() {
        Theme.appTheme = self.rawValue
    }
    
    static var current: Theme {
        return Theme(rawValue: appTheme) ?? .light
    }
}

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension Theme {
    
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:  return .light
        case .dark:   return .dark
        }
    }
    
    func setActive() {
        save()
        
        guard #available(iOS 13.0, *) else { return }
        
        UIApplication.shared.windows
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}

extension UIWindow {
    
    func initTheme() {
        guard #available(iOS 13.0, *) else { return }
        
        overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
    }
}

