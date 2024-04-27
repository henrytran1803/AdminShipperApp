//
//  ContentView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 26/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let login = UserDefaults.standard.bool(forKey: "isLogin")
        let role = UserDefaults.standard.string(forKey: "role")
        if login {
            if role == "shiper" {
                HomeShiperView()
            }else {
                HomeAdminView()
            }
        }else {
            WelcomeView()
        }
        
    }
}

#Preview {
    ContentView()
}
