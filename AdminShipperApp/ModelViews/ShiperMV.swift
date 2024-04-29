//
//  ShiperMV.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabaseInternal


class ShiperMV: ObservableObject {
    @Published var shipers: [Shiper] = []
    @Published var verifiedShippers: [ShipperVerify] = []

    init() {
        fetchShiperVerifyRealTime()
    }
    func findUID(cccd: String, completion: @escaping (String) -> Void){
        Database.database().reference().child("shiper").queryOrdered(byChild: "cccd").queryEqual(toValue: cccd).observeSingleEvent(of: .value) { snapshot in
            guard let uid = snapshot.children.allObjects.first as? DataSnapshot else {
                return
            }
            let shiperUID = uid.key
            completion(shiperUID)
            
        }
    }
    
    func fetchVerifiedShippers() {
        let db = Firestore.firestore()
        let usershiperRef = db.collection("usersshiper")
        
        let query = usershiperRef.whereField("verify", isEqualTo: "true")
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching verified shippers: \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else {
                print("No documents found")
                return
            }
            
            for document in snapshot.documents {
                do {
                    let shipperData = try document.data(as: ShipperVerify.self)
                    self.verifiedShippers.append(shipperData)
                } catch {
                    print("Error decoding document: \(error)")
                }
            }
        }
    }

    func fetchShiperVerifyRealTime(){
        Database.database().reference().child("shiper").observe(.value) { snapshot in
            var tempShipers: [Shiper] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let shiperDict = child.value as? [String: Any] {
                    if let name = shiperDict["name"] as? String,
                       let cccd = shiperDict["cccd"] as? String,
                       let diachi = shiperDict["diachi"] as? String,
                       let ngaysinh = shiperDict["ngaysinh"] as? String {
                        let shiper = Shiper(name: name, cccd: cccd, diachi: diachi, ngaysinh: ngaysinh)
                        tempShipers.append(shiper)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.shipers = tempShipers
                self.objectWillChange.send()
            }
        }
    }
}
