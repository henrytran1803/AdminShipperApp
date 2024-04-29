//
//  Order.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import Foundation
import Foundation
import FirebaseFirestore
import Firebase

struct Order: Codable {
    var userId: String
    var orderId: String
    var name: String
    var address: String
    var shiper: String
    var lat: String
    var long: String
}

enum StatusPayment:String, Codable {
    case no
    case pendding
    case done
}
enum Payment: Codable {
    case cash
    case applePay
    case crypto
}

struct Oder: Codable, Hashable {
    var name: String
    var adress: String
    var total: Double
    var discount :  Double
    var date: Timestamp
    var products : [Product]
    var status : StatusPayment
    var payment : Payment
}
