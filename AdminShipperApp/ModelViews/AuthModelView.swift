//
//  AuthModelView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    @Published var didAuthenticateUser = false
    private var tempUserSession: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: User session is \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let user = result?.user else {
                completion(false)
                return
            }
            
            self.userSession = user
            print("DEBUG: Did log user in...")
            UserDefaults.standard.set(true, forKey: "isLogin")
            completion(true)
        }
    }
    func checkUserRole(completion: @escaping (String?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No current user")
            completion(nil)
            return
        }
        
        let uid = user.uid
        let db = Firestore.firestore()
        let userRef = db.collection("usersshiper").document(uid)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("DEBUG: Failed to fetch user document with error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists else {
                print("DEBUG: User document does not exist")
                completion(nil)
                return
            }
            
            if let role = document.data()?["role"] as? String {
                print("DEBUG: User role is \(role)")
                UserDefaults.standard.set(role, forKey: "role")
                completion(role)
            } else {
                print("DEBUG: Role field not found or invalid data type")
                completion(nil)
            }
        }
    }
    func fetchFullName(completion: @escaping (String?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No current user")
            completion(nil)
            return
        }
        
        let uid = user.uid
        let db = Firestore.firestore()
        let userRef = db.collection("usersshiper").document(uid)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("DEBUG: Failed to fetch user document with error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists else {
                print("DEBUG: User document does not exist")
                completion(nil)
                return
            }
            
            if let role = document.data()?["fullname"] as? String {
                print("DEBUG: User role is \(role)")
                completion(role)
            } else {
                print("DEBUG: Role field not found or invalid data type")
                completion(nil)
            }
        }
    }

    func checkUserVerify(completion: @escaping (String?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No current user")
            completion(nil)
            return
        }
        
        let uid = user.uid
        let db = Firestore.firestore()
        let userRef = db.collection("usersshiper").document(uid)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("DEBUG: Failed to fetch user document with error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists else {
                print("DEBUG: User document does not exist")
                completion(nil)
                return
            }
            
            if let role = document.data()?["verify"] as? String {
                print("DEBUG: User role is \(role)")
                completion(role)
            } else {
                print("DEBUG: Role field not found or invalid data type")
                completion(nil)
            }
        }
    }
    func changeVerify(uid : String) {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No current user")
            return
        }
        let db = Firestore.firestore()
        let userRef = db.collection("usersshiper").document(uid)
        
        userRef.updateData(["verify": "true"]) { error in
            if let error = error {
                print("DEBUG: Failed to update verify field with error \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully updated verify field to true")
        }
    }

    func register(withEmail email: String, password: String, fullname: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let user = result?.user else {
                completion(false)
                return
            }
            
            self.tempUserSession = user
            print("DEBUG: Registered user successfully")
            print("DEBUG: User is \(self.userSession)")
            
            let data = ["email": email,
                        "fullname": fullname,
                        "role": "shiper",
                        "verify": "no",
                        "uid": user.uid]
            Firestore.firestore().collection("usersshiper")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                    completion(true) // Thông báo rằng đăng ký thành công
                }
        }
    }
    
    func signOut() {
        userSession = nil
        tempUserSession = nil
        didAuthenticateUser = false
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.set("", forKey: "role")
        UserDefaults.standard.set("", forKey: "verify")
        try? Auth.auth().signOut()
    }
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
        }
    }

}
