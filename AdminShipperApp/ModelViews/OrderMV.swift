//
//  OrderMV.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import Foundation
import FirebaseDatabaseInternal
import FirebaseAuth
import Firebase

class OrderMV: ObservableObject {
    @Published var orders: [Order] = []
    @Published var ordersShiper: [String: [Order]] = [:]
    func updateShipperForOrder(orderId: String, newShipper: String) {
        let ref = Database.database().reference().child("orders").child(orderId)
        ref.updateChildValues(["shiper": newShipper])
    }
    func deleteOrder(orderId: String) {
        let ref = Database.database().reference().child("orders").child(orderId)
        ref.removeValue { error, _ in
            if let error = error {
                print("Error deleting order: \(error.localizedDescription)")
            } else {
                print("Order deleted successfully")
            }
        }
    }
    func getOrder(userId: String, document: String, completion: @escaping (Oder?) -> Void) {
          let db = Firestore.firestore()
          let userDocumentRef = db.collection("users").document(userId)
          let orderDocumentRef = userDocumentRef.collection("orders").document(document)
          
          orderDocumentRef.getDocument { (document, error) in
              if let error = error {
                  print("Error fetching order document: \(error.localizedDescription)")
                  completion(nil)
                  return
              }
              
              guard let document = document, document.exists else {
                  print("Order document does not exist")
                  completion(nil)
                  return
              }
              do {
                  let order = try document.data(as: Oder.self)
                  completion(order)
              } catch {
                  print("Error parsing order data: \(error.localizedDescription)")
                  completion(nil)
              }

          }
      }
    func fetchOrders( completion: @escaping (Bool) -> Void) {
        Database.database().reference().child("orders").observeSingleEvent(of: .value) { snapshot in
            var tempOrders: [Order] = []

            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let orderData = child.value as? [String: Any] {
                    if let userId = orderData["userId"] as? String,
                       let orderId = orderData["orderId"] as? String,
                       let name = orderData["name"] as? String,
                       let address = orderData["diachi"] as? String,
                       let shipper = orderData["shiper"] as? String,
                       let lat = orderData["lat"] as? String,
                       let long = orderData["long"] as? String {
                        let order = Order(userId: userId, orderId: orderId, name: name, address: address, shiper: shipper, lat: lat, long: long)
                        tempOrders.append(order)
                    }
                }
            }
            DispatchQueue.main.async {
                self.orders = tempOrders
                self.objectWillChange.send()
                print(self.orders)
                completion(true)
            }
        }
    }
    func updateLongLatForOrder(orderId: String, newLong: String, newLat: String) {
        let ref = Database.database().reference().child("orders").child(orderId)
        ref.updateChildValues(["lat": newLat, "long": newLong]) { error, _ in
            if let error = error {
                print("Error updating long and lat for order \(orderId): \(error.localizedDescription)")
            } else {
                print("Successfully updated long and lat for order \(orderId)")
            }
        } 
    }

    func fetchShipsByShipper(shiper: String) {
        let ref = Database.database().reference().child("orders")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.exists() else {
                print("No data available")
                return
            }
            
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot,
                      let orderData = snap.value as? [String: Any],
                      let orderShipper = orderData["shiper"] as? String else {
                    continue
                }
                
                if orderShipper == shiper {
                    print("Found order for shipper: \(snap.key)")
                    if let userId = orderData["userId"] as? String,
                       let orderId = orderData["orderId"] as? String,
                       let name = orderData["name"] as? String,
                       let address = orderData["diachi"] as? String,
                       let shiper = orderData["shiper"] as? String,
                       let lat = orderData["lat"] as? String,
                       let long = orderData["long"] as? String {
                        let order = Order(userId: userId, orderId: orderId, name: name, address: address, shiper: shiper, lat: lat, long: long)
                        if var shipperOrders = self.ordersShiper[shiper] {
                            shipperOrders.append(order)
                            self.ordersShiper[shiper] = shipperOrders
                        } else {
                            self.ordersShiper[shiper] = [order]
                        }
                    }
                }
            }
        }
    }

}