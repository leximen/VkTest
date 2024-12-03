//
//  UnsplashData.swift
//  TestTest
//
//  Created by MacLex on 02.12.2024.
//

import Foundation

struct UnsplashData: Codable {
    let total: Int?
    let total_pages: Int?
    let results: [UnsplashResult]?
}


struct UnsplashResult: Codable {
    let id: String?
    let urls: Urls?
    let description: String?
    let likes: Int?
    let liked_by_user: Bool?
    let user: User?
}

struct Urls: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    let small_s3: String?
}

struct User: Codable {
    let name: String?
    let instagram_username: String?
    let profile_image: Urls?
}

