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
    @Published var ordersfiller: [Oder] = []
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
    func fetchAllOrders(completion: @escaping ([Oder]) -> Void) {
        let db = Firestore.firestore()
        let userCollectionRef = db.collection("users")

        userCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion([])
                return
            }
            
            var orders: [Oder] = []
            let dispatchGroup = DispatchGroup()

            for document in querySnapshot!.documents {
                print(document.documentID)
                let userId = document.documentID
                let orderDocumentRef = db.collection("users").document(userId).collection("orders")
                
                dispatchGroup.enter()
                orderDocumentRef.getDocuments { (querySnapshot, error) in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        print("Error fetching orders: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found")
                        return
                    }
                    
                    for document in documents {
                        do {
                            let order = try document.data(as: Oder.self)
                            orders.append(order)
                        } catch let error {
                            print("Error decoding document: \(error)")
                        }
                    }
                }
            }
            print(orders)
            dispatchGroup.notify(queue: .main) {
                completion(orders)
            }
        }
    }
    func fetchOrderBetweenDates(startDate: Timestamp, endDate: Timestamp, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let userCollectionRef = db.collection("users")

        userCollectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            let dispatchGroup = DispatchGroup()
            for document in querySnapshot!.documents {
                print(document.documentID)
                let userId = document.documentID
                let orderDocumentRef = db.collection("users").document(userId).collection("orders")
                orderDocumentRef.whereField("date", isGreaterThanOrEqualTo: startDate)
                               .whereField("date", isLessThanOrEqualTo: endDate)
                               .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error fetching orders: \(error.localizedDescription)")
                        return
                    }
                    
                                   guard let documents = querySnapshot?.documents else {
                                       print("No documents found")
                                       return
                                   }
                    
                    for document in documents {
                        do {
                            let order: Oder = try document.data(as: Oder.self)
                            self.ordersfiller.append(order)
                        } catch let error {
                            print("Error decoding document: \(error)")
                        }
                    }
                   
                }
                
            }
            completion(true)
        }
        
        
    }

    func fetchAllOrder(completion: @escaping ([Oder]) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No current user")
            return
        }
        
        let db = Firestore.firestore()
        let userId = currentUser.uid
        let userDocumentRef = db.collection("usersshiper").document(userId)
        let orderDocumentRef = userDocumentRef.collection("orders")
        
        orderDocumentRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            var orders : [Oder] = []
            
            for document in querySnapshot!.documents {
                do {
               var order: Oder = try document.data(as: Oder.self)
                    orders.append(order)
                    
                } catch let error {
                    print("Error decoding document: \(error)")
                }
            }
            completion(orders)
     
        }
    }
    func addOrder(value: Oder) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No current user")
            return
        }
        let db = Firestore.firestore()
        let userId = currentUser.uid
        let userDocumentRef = db.collection("usersshiper").document(userId)
        let documentCart = userDocumentRef.collection("orders").document()
        do {
          try documentCart.setData(from: value)
        }
        catch {
          print(error)
        }
    }
    func updateOrderStatus(orderID: String, userID: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No current user")
            return
        }
        
        let db = Firestore.firestore()
        let userIds = currentUser.uid
        let userDocumentRef = db.collection("usersshiper").document(userIds)
        
        let orderDocumentRef = userDocumentRef.collection("orders").document(orderID)
        
        let userorderRef = db.collection("users").document(userID).collection("orders").document(orderID)
        
        userorderRef.updateData(["status": "done"]) { error in
            if let error = error {
                print("Error updating order status: \(error.localizedDescription)")
            } else {
                print("Order status updated successfully")
            }
        }
        orderDocumentRef.updateData(["status": "done"]) { error in
            if let error = error {
                print("Error updating order status: \(error.localizedDescription)")
            } else {
                print("Order status updated successfully")
            }
        }
    }

}
