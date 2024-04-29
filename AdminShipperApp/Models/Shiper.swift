//
//  Shiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import Foundation
import FirebaseFirestore
import Firebase


struct Shiper: Codable {
    var name: String
    var cccd: String
    var diachi: String
    var ngaysinh: String
}
struct ShipperVerify: Codable, Hashable {
    var email: String
    var fullname: String
    var role: String
    var uid: String
    var verify: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid) 
    }
}
