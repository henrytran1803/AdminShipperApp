//
//  VerifyView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

import SwiftUI
import Firebase

struct VerifyView: View {
    @State private var cccd = ""
    @State private var address = ""
    @State private var dob = ""
    var body: some View {
        VStack {
            TextField("CCCD", text: $cccd)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            TextField("Địa chỉ", text: $address)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            TextField("Ngày sinh", text: $dob)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
   
            Button(action: {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                AuthViewModel().fetchFullName { name in
                    // Tạo một dictionary từ dữ liệu Shiper
                    let shiperData: [String: Any] = [
                        "name": name ?? "none",
                        "cccd": cccd,
                        "diachi": address,
                        "ngaysinh": dob
                    ]
                    
                    let ref = Database.database().reference().child("shiper").child(uid)
                    ref.setValue(shiperData)
                }
                }, label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color("buttonwelcome"))
                    .overlay{
                        Text("Gửi")
                            .bold()
                            .foregroundColor(.white)
                    }
            }).padding()
        }
        .padding()
    }
}


#Preview {
    VerifyView()
}
