//
//  ErrorNetwork.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import Foundation


enum ErrorNetwork: Error {
    case notURL
    case errorString(_ string: String)
    case `default`(_ error: Error)
    
    var description: String {
        switch self {
        case .notURL: return "Not url for push the request data"
        case .errorString(let string): return string
        case .default( let error): return error.localizedDescription
        }
    }
}
