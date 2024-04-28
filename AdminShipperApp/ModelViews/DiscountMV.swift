//
//  DiscountMV.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import Foundation
import Firebase
class DiscountMV : ObservableObject {
     func addDiscount(value: Discount) {
         let db = Firestore.firestore()
         let collectionRef = db.collection("discounts").document()
         do {
             try collectionRef.setData(from: value)
             print("Discount stored with new document reference: \(collectionRef.documentID)")
         } catch {
             print("Error adding discount: \(error)")
         }
     }
     func fetchDiscount(completion: @escaping ([Discount]) -> Void) {
         let db = Firestore.firestore()
         let collectionDiscount = db.collection("discounts")
         
         collectionDiscount.getDocuments { (querySnapshot, error) in
             if let error = error {
                 print("Error getting documents: \(error)")
                 completion([])
             } else {
                 var discounts: [Discount] = []
                 for document in querySnapshot!.documents {
                     do {
                         var discount: Discount = try document.data(as: Discount.self)
                         discounts.append(discount)
                     } catch let error {
                         print("Error decoding document: \(error)")
                     }
                 }
                 completion(discounts)
             }
         }
     }
    func deleteDiscount(name: String, completion: @escaping (Bool) -> Void) {
         let db = Firestore.firestore()
         let collectionRef = db.collection("discounts")
         collectionRef.whereField("code", isEqualTo: name).getDocuments { (querySnapshot, error) in
             if let error = error {
                 print("Error getting documents: \(error)")
             } else {
                 for document in querySnapshot!.documents {
                     document.reference.delete { error in
                         if let error = error {
                             print("Error removing document: \(error)")
                             completion(false)
                         } else {
                             print("Discount document successfully removed")
                             completion(true)
                         }
                     }
                 }
             }
         }
     }
 }

