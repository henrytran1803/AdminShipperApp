//
//  SettingView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct SettingView: View {
    @State var showVerifyView = false
    var body: some View {
        VStack{Spacer()
            Button(action: {
                AuthViewModel().signOut()
            }, label: {
                
                Text("Đăng xuất")
            })
            if showVerifyView {
                Button(action: {
                    NavigationLink{
                        VerifyView()
                    }label: {
                        Text("Bạn chưa verifyyy")
                    }
                    
                }, label: {
                    Text("Bạn chưa verifyyy")
                })
            }
            Spacer()
        }
        .onAppear {
            AuthViewModel().checkUserVerify { verify in
                UserDefaults.standard.set(verify, forKey: "verify")
                if verify == "true" {
                }else {
                    showVerifyView = true
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
