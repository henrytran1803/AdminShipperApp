//
//  ContentView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 26/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var alertVerify = false
    var body: some View {
        let login = UserDefaults.standard.bool(forKey: "isLogin")
        let role = UserDefaults.standard.string(forKey: "role")
        let verify = UserDefaults.standard.string(forKey: "verify")
        if login {
            if role == "shiper" {
                TabBarShiperView()
            }else {
                TabBarAdminView()
            }
        }else {
            WelcomeView()
        }
            
    }
}

#Preview {
    ContentView()
}
