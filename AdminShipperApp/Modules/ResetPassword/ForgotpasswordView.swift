//
//  ForgotpasswordView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct ForgotpasswordView: View {
    @State var userName = ""
    @State var openSignUp = false
    var body: some View {
        VStack(){
            HeaderSignIn()
            HStack{
                VStack(alignment: .leading){
                    Text("Forgot password")
                        .bold()
                        .font(.title)
                    Text("Welcome Back, You’ve been missed.")
                        .foregroundColor(.secondary)
                }.padding(.leading)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("Username")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.secondary)
                    TextField("Enter your username", text: $userName)
                        .padding()
                        .overlay(
                         RoundedRectangle(cornerRadius: 8)
                           .stroke(lineWidth: 2)
                           .foregroundColor(.gray)
                       )
            }.padding()
 
            Button(action: {
                AuthViewModel().sendPasswordReset(withEmail: userName)
            }, label: {
               RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color("buttonwelcome"))
                    .overlay{
                        Text("SIGN IN")
                            .bold()
                            .foregroundColor(.white)
                    }
            }).padding()

            HStack{
                Text("Đã nhớ tài khoản?")
                Button(action: {openSignUp = true}, label: {
                    Text("Đăng nhập")
                        .foregroundColor(Color.buttonwelcome)
                        .bold()
                })
            }.padding()

            Spacer()
                .fullScreenCover(isPresented: $openSignUp, content: {
                    SignIn()
                })

        }.ignoresSafeArea(.all)
           
    }
}

#Preview {
    ForgotpasswordView()
}
