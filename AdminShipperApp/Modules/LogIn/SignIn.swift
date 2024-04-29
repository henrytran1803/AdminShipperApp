//
//  SignIn.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct SignIn: View {
    @State var userName = ""
    @State var passWord = ""
    @State var openSignUp = false
    @State var openForgotPassword = false
    @State var  alerts = false
    @State var  isLogin = false
    @State var  isLoginAdmin = false
    @State var  alertShown = false
    var body: some View {
        VStack(){
            HeaderSignIn()
            HStack{
                VStack(alignment: .leading){
                    Text("Sign In")
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
            VStack(alignment: .leading, spacing: 0) {
                Text("Password")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.secondary)
                    SecureField("Enter your password", text: $passWord)
                        .padding()
                        .overlay(
                         RoundedRectangle(cornerRadius: 8)
                           .stroke(lineWidth: 2)
                           .foregroundColor(.gray)
                       )
            }.padding()
            HStack{
                Spacer()
                Button(action: {openForgotPassword = true}, label: {
                    Text("Forgot password")
                        .foregroundColor(Color.buttonwelcome)
                        .bold()
                })
            }.padding()
            Button(action: {
                AuthViewModel().login(withEmail: userName, password: passWord){success in
                    if success {
                        AuthViewModel().checkUserRole{ role in
                            if role == "shiper" {
                                isLogin = true
                            }else {
                                isLoginAdmin = true
                            }
                        }
                    }else {
                        self.alerts = false
                    }
                }
                
                
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
                .alert(isPresented: $alerts) {
                    () -> Alert in
                        Alert(title: Text("Alert Title"), message: Text("Alert Message"), dismissButton: .default(Text("Ok")))
                    }
            Button("Show Alert") {
                self.alertShown = true
            }.alert(isPresented: $alertShown) { () -> Alert in
                Alert(title: Text("Alert Title"), message: Text("Alert Message"), dismissButton: .default(Text("Ok")))
            }
            HStack{
                Text("Chưa có tài khoản?")
                Button(action: {openSignUp = true}, label: {
                    Text("Tạo tài khoản")
                        .foregroundColor(Color.buttonwelcome)
                        .bold()
                })
            }.padding()

            Spacer()
                .fullScreenCover(isPresented: $openSignUp, content: {
                    SignUp()
                })
                .fullScreenCover(isPresented: $openForgotPassword, content: {
                    ForgotpasswordView()
                })
                .fullScreenCover(isPresented: $isLogin, content: {
                    HomeShiperView()
                })
                .fullScreenCover(isPresented: $isLoginAdmin, content: {
                    HomeAdminView()
                })
        }.ignoresSafeArea(.all)
           
    }
}


#Preview {
    SignIn()
}
