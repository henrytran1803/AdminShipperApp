//
//  Category.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import Foundation
import Foundation
import FirebaseFirestore
import Firebase


struct Categories: Codable {
    var detail: String
    var image: String



    enum CodingKeys: String, CodingKey {
        case detail = "detail"
        case image = "image"
    }
  
}

struct Product: Codable, Hashable {
    var name: String
    var detail: String
    var price: Double
    var quality: Int
    var star: Double
    var image: String
    var categoryName: String
}

struct CategoriesDetail: Codable {
    var name : String
    var category: Categories
}
