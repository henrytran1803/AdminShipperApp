//
//  DetailShiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI
import FirebaseDatabaseInternal

struct DetailShiper: View {
    @State var shiper: Shiper
    @State var uid = ""
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Name")
                    .bold()
                    .foregroundColor(.secondary)
                TextField("Name", text: $shiper.name)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    )
                    .disabled(true)
                Text("CCCD")
                    .bold()
                    .foregroundColor(.secondary)
                TextField("CCCD", text: $shiper.cccd)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    )
                    .disabled(true)
                Text("Ngày sinh")
                    .bold()
                    .foregroundColor(.secondary)
                TextField("Ngày sinh", text: $shiper.ngaysinh)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    )
                    .disabled(true)
                Text("Địa chỉ")
                    .bold()
                    .foregroundColor(.secondary)
                TextField("Địa chỉ", text: $shiper.diachi)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    )
                    .disabled(true)
            }
            HStack{
                Button(action: {
                    let shiperRef = Database.database().reference().child("shiper").child(uid)
                    shiperRef.removeValue()
                    
                    }, label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 60)
                        .foregroundColor(Color.pink)
                        .overlay{
                            Text("Từ chối")
                                .bold()
                                .foregroundColor(.white)
                        }
                }).padding()
                Button(action: {
                    let shiperRef = Database.database().reference().child("shiper").child(uid)
                    shiperRef.removeValue()
                    AuthViewModel().changeVerify(uid: uid)
                    }, label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 60)
                        .foregroundColor(Color("buttonwelcome"))
                        .overlay{
                            Text("Chấp nhận")
                                .bold()
                                .foregroundColor(.white)
                        }
                }).padding()
            }

        }
        .onAppear{
            ShiperMV().findUID(cccd: shiper.cccd){ uid in
                self.uid = uid
                
            }
        }
    }
}

#Preview {
    DetailShiper(shiper: Shiper(name: "name", cccd: "12312", diachi: "adssa", ngaysinh: "ádá"))
}
//.sheet(isPresented: $showingCredits) {
//          Text("This app was brought to you by Hacking with Swift")
//              .presentationDetents([.medium, .large])
//              .presentationDragIndicator(.hidden)
//      }
